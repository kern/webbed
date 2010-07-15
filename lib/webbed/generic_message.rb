module Webbed
  module GenericMessage
    
    attr_writer :entity_body
    
    # Must be overridden
    def start_line
      "Invalid Start Line\r\n"
    end
    
    def http_version
      @http_version ||= Webbed::HTTPVersion::ONE_POINT_ONE
    end
    
    def http_version=(http_version)
      @http_version = Webbed::HTTPVersion.new(http_version)
    end
    
    def headers
      @headers ||= Webbed::Headers.new
    end
    
    def entity_body
      @entity_body ||= ''
    end
    
    def to_s
      "#{start_line}#{headers.to_s}\r\n#{entity_body}"
    end
  end
end