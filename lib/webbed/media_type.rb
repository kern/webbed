module Webbed
  class MediaType
    
    attr_accessor :type, :subtype, :parameters
    REGEX = /^([-\w.+]+)\/([-\w.+]*)$/
    PARAMETERS_REGEX = /=|\s*;\s*/
    
    def initialize(media_type)
      self.mime_type, *parameters = media_type.split(/=|\s*;\s*/)
      self.parameters = Hash[*parameters] || {}
    end
    
    def mime_type
      "#{type}/#{subtype}"
    end
    
    def mime_type=(mime_type)
      match = mime_type.match REGEX
      self.type = match[1]
      self.subtype = match[2]
    end
    
    def to_s
      if parameters.empty?
        mime_type
      else
        parameters = self.parameters.map { |k, v| "#{k}=#{v}" }.join '; '
        "#{mime_type}; #{parameters}"
      end
    end
    
    def vendor_specific?
      subtype[0..3] == 'vnd.'
    end
    
    def suffix
      suffix = subtype.split('+')[-1]
      
      if suffix != subtype
        suffix
      else
        nil
      end
    end
    
    def interpretable_as
      if suffix
        [mime_type, "#{type}/#{suffix}"]
      else
        [mime_type]
      end
    end
  end
end