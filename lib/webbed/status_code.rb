module Webbed
  class StatusCode
    include Comparable
    attr_reader :status_code, :default_reason_phrase
    alias :to_i :status_code
    
    CACHED = {}
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
    
    def self.new(status_code)
      CACHED[status_code] ||= super(status_code)
    end
    
    def initialize(status_code)
      status_code = status_code.to_i
      @status_code = status_code
      @default_reason_phrase = REASON_PHRASES[status_code] || UNKNOWN_REASON_PHRASE
    end
    
    def <=>(other_status_code)
      status_code <=> other_status_code.to_i
    end
    
    def to_s
      status_code.to_s
    end
    
    def informational?
      (100...200).include? status_code
    end
    
    def success?
      (200...300).include? status_code
    end
    
    def redirection?
      (300...400).include? status_code
    end
    
    def client_error?
      (400...500).include? status_code
    end
    
    def server_error?
      (500...600).include? status_code
    end
    
    def unknown?
      !(100...600).include? status_code
    end
    
    def error?
      (400...600).include? status_code
    end
  end
end