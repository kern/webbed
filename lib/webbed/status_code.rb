module Webbed
  # Representation of HTTP Status Codes
  class StatusCode
    include Comparable
    
    UNKNOWN_REASON_PHRASE = 'Unknown Status Code'
    REASON_PHRASES = {
      100 => 'Continue',
      101 => 'Switching Protocols',
      200 => 'OK',
      201 => 'Created',
      202 => 'Accepted',
      203 => 'Non-Authoritative Information',
      204 => 'No Content',
      205 => 'Reset Content',
      206 => 'Partial Content',
      300 => 'Multiple Choices',
      301 => 'Moved Permanently',
      302 => 'Found',
      303 => 'See Other',
      304 => 'Not Modified',
      305 => 'Use Proxy',
      307 => 'Temporary Redirect',
      400 => 'Bad Request',
      401 => 'Unauthorized',
      402 => 'Payment Required',
      403 => 'Forbidden',
      404 => 'Not Found',
      405 => 'Method Not Allowed',
      406 => 'Not Acceptable',
      407 => 'Proxy Authentication Required',
      408 => 'Request Time-out',
      409 => 'Conflict',
      410 => 'Gone',
      411 => 'Length Required',
      412 => 'Precondition Failed',
      413 => 'Request Entity Too Large',
      414 => 'Request-URI Too Large',
      415 => 'Unsupported Media Type',
      416 => 'Requested range not satisfiable',
      417 => 'Expectation Failed',
      500 => 'Internal Server Error',
      501 => 'Not Implemented',
      502 => 'Bad Gateway',
      503 => 'Service Unavailable',
      504 => 'Gateway Time-out',
      505 => 'HTTP Version not supported'
    }
    
    @@cached = {}
    
    # The default Reason Phrase of the Status Code
    # 
    # @return [String]
    attr_reader :default_reason_phrase
    
    # Retrieves a Status Code from the cache or creates a new one
    # 
    # All created Status Codes are cached forever.
    # 
    # @param (see #initialize)
    # @return [StatusCode] the new or cached StatusCode
    # @see #initialize
    def self.new(status_code)
      status_code = status_code.to_i
      @@cached[status_code] ||= super(status_code)
    end
    
    # Creates a new Status Code
    # 
    # @param [Fixnum] status_code
    def initialize(status_code)
      @status_code = status_code
      @default_reason_phrase = REASON_PHRASES[@status_code] || UNKNOWN_REASON_PHRASE
    end
    
    # Comparse the Status Code to another Status Code
    # 
    # @param [#to_i] other_status_code the other Status Code
    # @return [Fixnum] the sign of the comparison (either `1`, `0`, or `-1`)
    def <=>(other_status_code)
      @status_code <=> other_status_code.to_i
    end
    
    # Converts the Status Code to an integer
    # 
    # @return [Fixnum]
    def to_i
      @status_code
    end
    
    # Converts the Status Code to a string
    # 
    # @return [String]
    def to_s
      @status_code.to_s
    end
    
    # Whether or not the Status Code is informational
    # 
    # According to RFC 2616, informational status codes are in the range of 100
    # to 199, inclusive.
    # 
    # @return [Boolean]
    def informational?
      (100...200).include?(@status_code)
    end
    
    # Whether or not the Status Code is successful
    # 
    # According to RFC 2616, successful status codes are in the range of 200 to
    # 299, inclusive.
    # 
    # @return [Boolean]
    def successful?
      (200...300).include?(@status_code)
    end
    
    # Whether or not the Status Code is a redirection
    # 
    # According to RFC 2616, redirection status codes are in the range of 300 to
    # 399, inclusive.
    # 
    # @return [Boolean]
    def redirection?
      (300...400).include?(@status_code)
    end
    
    # Whether or not the Status Code is a client error
    # 
    # According to RFC 2616, client error status codes are in the range of 400
    # to 499, inclusive.
    # 
    # @return [Boolean]
    def client_error?
      (400...500).include?(@status_code)
    end
    
    # Whether or not the Status Code is a server error
    # 
    # According to RFC 2616, server error status codes are in the range of 500
    # to 599, inclusive.
    # 
    # @return [Boolean]
    def server_error?
      (500...600).include?(@status_code)
    end
    
    # Whether or not the Status Code is unknown
    # 
    # According to RFC 2616, the only defined Status Code ranges are from 100 to
    # 599, inclusive. Anything outside that range is an unknown Status Code.
    # 
    # @return [Boolean]
    def unknown?
      !(100...600).include?(@status_code)
    end
    
    # Whether or not the Status Code is an error
    # 
    # According to RFC 2616, Status Codes that signify errors are in the range
    # of 400 to 599, inclusive.
    # 
    # @return [Boolean]
    def error?
      (400...600).include?(@status_code)
    end
  end
end