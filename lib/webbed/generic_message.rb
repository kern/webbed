module Webbed
  # Generic methods used for both {Request}'s and {Response}'s.
  # @abstract
  module GenericMessage
    # Returns the HTTP Version of the message.
    # 
    # Automatically converts the HTTP Version to an instance of {HTTPVersion} if
    # it is not already one.
    attr_reader :http_version
    
    # Returns the headers of the message.
    # 
    # Automatically converts the headers to an instance of {Headers} if it
    # is not already one.
    attr_reader :headers
    
    # Returns the entity body of the message.
    attr_accessor :entity_body
    
    def headers=(headers)
      @headers = Webbed::Headers.new(headers)
    end
    
    def http_version=(http_version)
      @http_version = Webbed::HTTPVersion.new(http_version)
    end
    
    # Convert the message into an HTTP message as per RFC 2616.
    # 
    # @return [String] the HTTP message
    def to_s
      "#{start_line}#{headers.to_s}\r\n#{entity_body}"
    end
  end
end