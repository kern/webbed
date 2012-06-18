require "webbed/registry"

module Webbed
  # `StatusCode` represents an HTTP status code. It also sets the status code's
  # default reason phrase.
  #
  # @author Alexander Simon Kern (alex@kernul)
  # @api public
  class StatusCode
    extend SingleForwardable
    include Comparable

    @registry = Registry.new { |obj| obj.to_i }
    def_single_delegators :@registry, :register, :unregister, :look_up

    # Returns the default reason phrase of the status code.
    #
    # @return [String]
    attr_reader :default_reason_phrase

    # Creates a new status code.
    #
    # @param [Fixnum] integer the integer representation of the status code
    # @param [String] default_reason_phrase the default reason phrase of the status code
    def initialize(integer, default_reason_phrase)
      @integer = integer
      @default_reason_phrase = default_reason_phrase
    end

    # Converts the status code to an integer.
    #
    # @return [Fixnum]
    def to_i
      @integer
    end

    # Returns whether or not the status code is informational.
    #
    # @return [Boolean]
    def informational?
      (100..199).include?(to_i)
    end

    # Returns whether or not the status code is successful.
    #
    # @return [Boolean]
    def successful?
      (200..299).include?(to_i)
    end

    # Returns whether or not the status code is a redirection.
    #
    # @return [Boolean]
    def redirection?
      (300..399).include?(to_i)
    end

    # Returns whether or not the status code is a client error.
    #
    # @return [Boolean]
    def client_error?
      (400..499).include?(to_i)
    end

    # Returns whether or not the status code is a server error.
    #
    # @return [Boolean]
    def server_error?
      (500..599).include?(to_i)
    end

    # Returns whether or not the status code is an error.
    #
    # @return [Boolean]
    def error?
      client_error? || server_error?
    end

    # Returns whether or not the status code is unknown.
    #
    # @return [Boolean]
    def unknown?
      !(100..599).include?(to_i)
    end

    # Compares two status codes.
    #
    # @param [StatusCode] other
    # @return [-1, 0, 1, nil]
    def <=>(other)
      [to_i, default_reason_phrase] <=> [other.to_i, other.default_reason_phrase]
    rescue NoMethodError
      nil
    end

    CONTINUE                         = register(new(100, "Continue"))
    SWITCHING_PROTOCOLS              = register(new(101, "Switching Protocols"))

    OK                               = register(new(200, "OK"))
    CREATED                          = register(new(201, "Created"))
    ACCEPTED                         = register(new(202, "Accepted"))
    NONAUTHORITATIVE_INFORMATION     = register(new(203, "Non-Authoritative Information"))
    NO_CONTENT                       = register(new(204, "No Content"))
    RESET_CONTENT                    = register(new(205, "Reset Content"))
    PARTIAL_CONTENT                  = register(new(206, "Partial Content"))

    MULTIPLE_CHOICES                 = register(new(300, "Multiple Choices"))
    MOVED_PERMANENTLY                = register(new(301, "Moved Permanently"))
    FOUND                            = register(new(302, "Found"))
    SEE_OTHER                        = register(new(303, "See Other"))
    NOT_MODIFIED                     = register(new(304, "Not Modified"))
    USE_PROXY                        = register(new(305, "Use Proxy"))
    TEMPORARY_REDIRECT               = register(new(307, "Temporary Redirect"))

    BAD_REQUEST                      = register(new(400, "Bad Request"))
    UNAUTHORIZED                     = register(new(401, "Unauthorized"))
    PAYMENT_REQUIRED                 = register(new(402, "Payment Required"))
    FORBIDDEN                        = register(new(403, "Forbidden"))
    NOT_FOUND                        = register(new(404, "Not Found"))
    METHOD_NOT_ALLOWED               = register(new(405, "Method Not Allowed"))
    NOT_ACCEPTABLE                   = register(new(406, "Not Acceptable"))
    PROXY_AUTHENTICATION_REQUIRED    = register(new(407, "Proxy Authentication Required"))
    REQUEST_TIMEOUT                  = register(new(408, "Request Time-out"))
    CONFLICT                         = register(new(409, "Conflict"))
    GONE                             = register(new(410, "Gone"))
    LENGTH_REQUIRED                  = register(new(411, "Length Required"))
    PRECONDITION_FAILED              = register(new(412, "Precondition Failed"))
    REQUEST_REPRESENTATION_TOO_LARGE = register(new(413, "Request Representation Too Large"))
    URI_TOO_LONG                     = register(new(414, "URI Too Long"))
    UNSUPPORTED_MEDIA_TYPE           = register(new(415, "Unsupported Media Type"))
    REQUESTED_RANGE_NOT_SATISFIABLE  = register(new(416, "Requested range not satisfiable"))
    EXPECTATION_FAILED               = register(new(417, "Expectation Failed"))
    UPGRADE_REQUIRED                 = register(new(426, "Upgrade Required"))

    INTERNAL_SERVER_ERROR            = register(new(500, "Internal Server Error"))
    NOT_IMPLEMENTED                  = register(new(501, "Not Implemented"))
    BAD_GATEWAY                      = register(new(502, "Bad Gateway"))
    SERVICE_UNAVAILABLE              = register(new(503, "Service Unavailable"))
    GATEWAY_TIMEOUT                  = register(new(504, "Gateway Time-out"))
    HTTP_VERSION_NOT_SUPPORTED       = register(new(505, "HTTP Version not supported"))
  end
end
