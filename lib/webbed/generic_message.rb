module Webbed
  # Generic methods used for both {Request}'s and {Response}'s.
  # 
  # @abstract Include and implement `#status_line`.
  module GenericMessage
    # The HTTP-Version of the message.
    # 
    # The method automatically converts the new value to an instance of
    # {HTTPVersion} if it is not already one.
    # 
    # @return [HTTPVersion]
    attr_reader :http_version
    
    def http_version=(http_version)
      @http_version = Webbed::HTTPVersion.new(http_version)
    end
    
    # The Headers of the message.
    # 
    # The method automatically converts the new value to an instance of
    # {Headers} if it is not already one.
    # 
    # @return [Headers]
    attr_reader :headers
    
    def headers=(headers)
      @headers = Webbed::Headers.new(headers)
    end
    
    # The Entity Body of the message.
    # 
    # @return [#to_s]
    attr_accessor :entity_body
    
    # Converts the message into an HTTP Message as per RFC 2616.
    # 
    # @return [String]
    def to_s
      "#{start_line}#{headers.to_s}\r\n#{entity_body}"
    end
  end
end