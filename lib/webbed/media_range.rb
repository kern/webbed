module Webbed
  # Representation of an HTTP Media Range.
  class MediaRange < MediaType
    GLOBAL_GROUP_REGEX = /^(\*)\/(\*)$/
    TYPE_GROUP_REGEX = /^([-\w.+]+)\/(\*)$/
    
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
    # @param [MediaType] media_type
    def include?(media_type)
      if ['*', media_type.type].include?(type) && ['*', media_type.subtype].include?(subtype)
        accept_extensions.empty? || accept_extensions == media_type.parameters
      else
        false
      end
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
  end
end