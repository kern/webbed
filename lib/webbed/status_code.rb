module Webbed
  # Representation of an HTTP Status Code.
  class StatusCode
    include Comparable
    
    UNKNOWN_REASON_PHRASE = 'Unknown Status Code'
    
    class << self
      # The registered Status Codes.
      # 
      # @return [{Fixnum => Webbed::StatusCode}]
      def registered
        @registered ||= {}
      end
      
      # The default Reason Phrases for Status Codes.
      # 
      # @return [{Fixnum => String}]
      def default_reason_phrases
        @default_reason_phrases ||= {}
      end
      
      # Registers a Status Code and its default Reason Phrase.
      # 
      # @param [#to_i] status_code the Status Code
      # @param [String] default_reason_phrase the default Reason Phrase
      # @return [Webbed::StatusCode]
      def register(status_code, default_reason_phrase)
        default_reason_phrases[status_code.to_i] = default_reason_phrase
        registered[status_code.to_i] = new(status_code)
      end
      
      # Looks up the registered Status Code or returns a temporary one.
      # 
      # @param [#to_i] status_code the Status Code
      # @return [Webbed::StatusCode]
      def lookup(status_code)
        registered[status_code.to_i] || new(status_code)
      end
    end
    
    # The default Reason Phrase of the Status Code.
    # 
    # @return [String]
    attr_reader :default_reason_phrase
        
    # Creates a new Status Code.
    # 
    # @param [#to_i] status_code
    def initialize(status_code)
      @status_code = status_code.to_i
      @default_reason_phrase = self.class.default_reason_phrases[@status_code] || UNKNOWN_REASON_PHRASE
    end
    
    # Compares the Status Code to another Status Code.
    # 
    # @param [#to_i] other_status_code the other Status Code
    # @return [Fixnum] the sign of the comparison (either `1`, `0`, or `-1`)
    def <=>(other_status_code)
      @status_code <=> other_status_code.to_i
    end
    
    # Converts the Status Code to an integer.
    # 
    # @return [Fixnum]
    def to_i
      @status_code
    end
    
    # Converts the Status Code to a string.
    # 
    # @return [String]
    def to_s
      @status_code.to_s
    end
    
    # Whether or not the Status Code is informational.
    # 
    # According to RFC 2616, informational status codes are in the range of 100
    # to 199, inclusive.
    # 
    # @return [Boolean]
    def informational?
      (100...200).include?(@status_code)
    end
    
    # Whether or not the Status Code is successful.
    # 
    # According to RFC 2616, successful status codes are in the range of 200 to
    # 299, inclusive.
    # 
    # @return [Boolean]
    def successful?
      (200...300).include?(@status_code)
    end
    
    # Whether or not the Status Code is a redirection.
    # 
    # According to RFC 2616, redirection status codes are in the range of 300 to
    # 399, inclusive.
    # 
    # @return [Boolean]
    def redirection?
      (300...400).include?(@status_code)
    end
    
    # Whether or not the Status Code is a client error.
    # 
    # According to RFC 2616, client error status codes are in the range of 400
    # to 499, inclusive.
    # 
    # @return [Boolean]
    def client_error?
      (400...500).include?(@status_code)
    end
    
    # Whether or not the Status Code is a server error.
    # 
    # According to RFC 2616, server error status codes are in the range of 500
    # to 599, inclusive.
    # 
    # @return [Boolean]
    def server_error?
      (500...600).include?(@status_code)
    end
    
    # Whether or not the Status Code is unknown.
    # 
    # According to RFC 2616, the only defined Status Code ranges are from 100 to
    # 599, inclusive. Anything outside that range is an unknown Status Code.
    # 
    # @return [Boolean]
    def unknown?
      !(100...600).include?(@status_code)
    end
    
    # Whether or not the Status Code is an error.
    # 
    # According to RFC 2616, Status Codes that signify errors are in the range
    # of 400 to 599, inclusive.
    # 
    # @return [Boolean]
    def error?
      (400...600).include?(@status_code)
    end
    
    register(100, 'Continue')
    register(101, 'Switching Protocols')
    register(200, 'OK')
    register(201, 'Created')
    register(202, 'Accepted')
    register(203, 'Non-Authoritative Information')
    register(204, 'No Content')
    register(205, 'Reset Content')
    register(206, 'Partial Content')
    register(300, 'Multiple Choices')
    register(301, 'Moved Permanently')
    register(302, 'Found')
    register(303, 'See Other')
    register(304, 'Not Modified')
    register(305, 'Use Proxy')
    register(307, 'Temporary Redirect')
    register(400, 'Bad Request')
    register(401, 'Unauthorized')
    register(402, 'Payment Required')
    register(403, 'Forbidden')
    register(404, 'Not Found')
    register(405, 'Method Not Allowed')
    register(406, 'Not Acceptable')
    register(407, 'Proxy Authentication Required')
    register(408, 'Request Time-out')
    register(409, 'Conflict')
    register(410, 'Gone')
    register(411, 'Length Required')
    register(412, 'Precondition Failed')
    register(413, 'Request Entity Too Large')
    register(414, 'Request-URI Too Large')
    register(415, 'Unsupported Media Type')
    register(416, 'Requested range not satisfiable')
    register(417, 'Expectation Failed')
    register(500, 'Internal Server Error')
    register(501, 'Not Implemented')
    register(502, 'Bad Gateway')
    register(503, 'Service Unavailable')
    register(504, 'Gateway Time-out')
    register(505, 'HTTP Version not supported')
  end
end