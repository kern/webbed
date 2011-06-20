module Webbed
  # Representation of an HTTP Media Type.
  class MediaType
    MIME_TYPE_REGEX = /^([-\w.+]+)\/([-\w.+]*)$/
    PARAMETERS_REGEX = /=|\s*;\s*/
    
    # The type of the MIME type.
    # 
    # According to RFC 2616, this is the part *before* the slash.
    # 
    # @example
    #     media_type = Webbed::MediaType.new('text/html')
    #     media_type.type # => 'text'
    # 
    # @return [String]
    attr_accessor :type
    
    # The subtype of the MIME type.
    # 
    # According to RFC 2616, this is the *after* before the slash.
    # 
    # @example
    #     media_type = Webbed::MediaType.new('text/html')
    #     media_type.type # => 'html'
    # 
    # @return [String]
    attr_accessor :subtype
    
    # The parameters of the Media Type.
    # 
    # According to RFC 2616, parameters are separated from the MIME type and
    # each other using a semicolon.
    # 
    # @example
    #     media_type = Webbed::MediaType.new('text/html; q=1.0')
    #     media_type.parameters # => { 'q' => '1.0' }
    # 
    # @return [Hash{String => String}]
    attr_accessor :parameters
    
    # Creates a new Media Type.
    # 
    # @example Create a MediaType without parameters
    #     media_type = Webbed::MediaType.new('text/html')
    #     media_type.mime_type # => 'text/html'
    #     media_type.parameters # => {}
    # 
    # @example Create a MediaType with parameters
    #     media_type = Webbed::MediaType.new('text/html; q=1.0')
    #     media_type.mime_type # => 'text/html'
    #     media_type.parameters # => { 'q' => '1.0' }
    # 
    # @param [String] media_type the Media Type to create as defined in RFC 2616
    def initialize(media_type)
      self.mime_type, *parameters = media_type.split(PARAMETERS_REGEX)
      self.parameters = Hash[*parameters] || {}
    end
    
    # The MIME type of the Media Type.
    # 
    # @return [String]
    def mime_type
      "#{type}/#{subtype}"
    end
    
    # Sets the MIME type of the Media Type.
    # 
    # @param [String] mime_type
    def mime_type=(mime_type)
      MIME_TYPE_REGEX =~ mime_type
      self.type = $1
      self.subtype = $2
    end
    
    # Converts the Media Type to a string.
    # 
    # @return [String]
    def to_s
      if parameters.empty?
        mime_type
      else
        parameters = self.parameters.map { |k, v| "#{k}=#{v}" }.join('; ')
        "#{mime_type}; #{parameters}"
      end
    end
    
    # Whether or not the Media Type is vendor-specific.
    # 
    # The method uses the `vnd.` prefix convention to determine whether or not
    # it was created for a specific vendor.
    # 
    # @example
    #     media_type = Webbed::MediaType.new('application/json')
    #     media_type.vendor_specific? # => false
    #     
    #     media_type = Webbed::MediaType.new('application/vnd.my-special-type')
    #     media_type.vendor_specific? # => true
    # 
    # @return [Boolean]
    def vendor_specific?
      subtype[0..3] == 'vnd.'
    end
    
    # The suffix of the MIME type.
    # 
    # Suffixes follow the convention set forth by the Atom specification:
    # separated from the rest of the MIME Type by a `+`.
    # 
    # @example
    #     media_type = Webbed::MediaType.new('application/xml')
    #     media_type.suffix # => nil
    #     
    #     media_type = Webbed::MediaType.new('application/atom+xml')
    #     media_type.suffix # => 'xml'
    # 
    # @return [String, nil]
    def suffix
      suffix = subtype.split('+')[-1]
      
      if suffix != subtype
        suffix
      else
        nil
      end
    end
    
    # Compares the Media Type to another Media Type.
    # 
    # Two Media Types are equal if their `#mime_type`s are equal.
    # 
    # @param [#mime_type] other_media_type the other Media Type
    # @return [Boolean]
    def ==(other_media_type)
      return false unless other_media_type.respond_to?(:mime_type)
      mime_type == other_media_type.mime_type
    end
    
    # The MIME types that the Media Type can be interpreted as.
    # 
    # This uses the suffix to generate a list of MIME types that can be used to
    # interpret the Media Type. It's useful if you need to be able to parse XML
    # or JSON Media Types that may or may not have suffixes using general XML
    # or JSON parsers.
    # 
    # @example
    #     media_type = Webbed::MediaType.new('application/xml')
    #     media_type.interpretable_as # ['application/xml']
    #     
    #     media_type = Webbed::MediaType.new('application/atom+xml')
    #     media_type.interpretable_as # => ['application/atom+xml', 'application/xml']
    # 
    # @return [Array<String>]
    def interpretable_as
      if suffix
        [mime_type, "#{type}/#{suffix}"]
      else
        [mime_type]
      end
    end
  end
end