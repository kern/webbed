module Webbed
  module GenericMessage
    
    attr_reader :http_version
    attr_accessor :entity_body
    
    # This is purely for test/spec purposes.
    def initialize
      self.http_version = 'HTTP/1.1'
      self.entity_body = ''
    end
    
    # Must be overridden!
    def start_line
      "Invalid Start Line\r\n"
    end
    
    def http_version=(http_version)
      @http_version = Webbed::HTTPVersion.new(http_version)
    end
    
    def headers
      @headers ||= Webbed::Headers.new
    end
    
    def to_s
      "#{start_line}#{headers.to_s}\r\n#{entity_body}"
    end
  end
end