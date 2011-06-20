module Webbed
  # Representation of an HTTP Media Range.
  class MediaRange < MediaType
    include Comparable
    
    GLOBAL_GROUP_REGEX = /^(\*)\/(\*)$/
    TYPE_GROUP_REGEX = /^([-\w.+]+)\/(\*)$/
    
    attr_accessor :order
    
    # Creates a new Media Range.
    # 
    # @param [String] media_range the Media Range to create as defined in RFC 2616
    # @param [Hash] options the options to create the Media Range with
    # @option options [Fixnum] :order (0) the order of the Media Range
    # @see MediaType#initialize
    def initialize(media_range, options = {})
      self.order = options.delete(:order) || 0
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
    
    # Compares the Media Range to another Media Range.
    # 
    # It sorts Media Ranges by quality and order, in that order.
    # 
    # @param [Webbed::MediaRange] other_media_range
    # @see #specificity
    def <=>(other_media_range)
      result = quality <=> other_media_range.quality
      result = other_media_range.order <=> order if result == 0
      
      result
    end
    
    # The specificity of the Media Range.
    # 
    # This is not explicitly defined in RFC 2616 but it helps for sorting.
    # 
    # * Global group: 0
    # * Type group: 1
    # * Suffixed Media Type: 1000 + the number of accept-extensions
    # * Media Type: 2 + the number of accept-extensions
    def specificity
      return 0 if type == '*'
      return 1 if subtype == '*'
      return 1000 + accept_extensions.length if suffix
      return 2 + accept_extensions.length
    end
    
    # (see MediaType#to_s)
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