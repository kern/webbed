module Webbed
  # Representation of an HTTP Media Range.
  class MediaRange < MediaType
    include Webbed::Negotiable
    
    GLOBAL_GROUP_REGEX = /^(\*)\/(\*)$/
    TYPE_GROUP_REGEX = /^([-\w.+]+)\/(\*)$/
    
    # The order of the Media Range.
    # 
    # @return [Fixnum]
    attr_accessor :order
    
    # Creates a new Media Range.
    # 
    # @param [String] media_range the Media Range to create as defined in RFC 2616
    # @param [Hash] options the options to create the Media Range with
    # @option options [Fixnum] :order (0) the order of the Media Range
    # @see Webbed::MediaType#initialize
    def initialize(media_range, options = {})
      self.order = options.fetch(:order, 0)
      super(media_range)
    end
    
    # Sets the MIME type of the Media Range.
    # 
    # @param [String] mime_type
    def mime_type=(mime_type)
      GLOBAL_GROUP_REGEX =~ mime_type ||
        TYPE_GROUP_REGEX =~ mime_type ||
        MIME_TYPE_REGEX =~ mime_type
      
      self.type = $1
      self.subtype = $2
    end
    
    # Whether or not the Media Type is in the Media Range.
    # 
    # @param [Webbed::MediaType] media_type
    def include?(media_type)
      ['*', media_type.type].include?(type) &&
        ['*', media_type.subtype].include?(subtype) &&
        (accept_extensions.empty? || accept_extensions == media_type.parameters)
    end
    
    # The accept-extensions of the Media Range (all the parameters except for "q").
    # 
    # @return [{String => String}]
    def accept_extensions
      parameters.reject { |k, v| k == 'q' }
    end
    
    # The quality of the Media Range (as defined in the "q" parameter).
    # 
    # @return [Float]
    def quality
      parameters['q'] ? parameters['q'].to_f : 1.0
    end
    
    # Sets the quality of the Media Range (as defined in the "q" parameter).
    # 
    # @param [#to_s] quality
    def quality=(quality)
      parameters['q'] = quality.to_s
    end
    
    # The precedence of the Media Range.
    # 
    # This is not well defined in RFC 2616 but it helps for sorting.
    # 
    # * Global group: [0, 0]
    # * Type group: [1, 0]
    # * Media Type: [2, the number of accept-extensions]
    # * Suffixed Media Type: [3, the number of accept-extensions]
    def precedence
      return [0, 0] if type == '*'
      return [1, 0] if subtype == '*'
      return [2, accept_extensions.length] unless suffix
      return [3, accept_extensions.length]
    end
    
    # (see Webbed::MediaType#to_s)
    def to_s
      result = parameters['q'] ? "#{mime_type}; q=#{parameters['q']}" : mime_type
      
      if !accept_extensions.empty?
        accept_extensions = self.accept_extensions.map { |k, v| "#{k}=#{v}" }.join('; ')
        result += "; #{accept_extensions}"
      end
      
      result
    end
  end
end