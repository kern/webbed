module Webbed
  module GenericMessage
    attr_reader :headers, :http_version
    attr_accessor :entity_body
    
    def headers=(headers)
      @headers = Webbed::Headers.new(headers)
    end
    
    def http_version=(http_version)
      @http_version = Webbed::HTTPVersion.new(http_version)
    end
    
    def to_s
      "#{start_line}#{headers.to_s}\r\n#{entity_body}"
    end
  end
end