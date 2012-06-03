require "webbed/registry"

module Webbed
  # `Method` represents an HTTP method (i.e. GET, HEAD, POST).
  #
  # @author Alex Kern
  # @api public
  class Method
    extend Registry

    # Creates a new method.
    #
    # @param [String] string the string representation of the method
    # @param [Hash] options miscellaneous options for the method
    # @option options [Boolean] :safe whether or not the method is safe
    # @option options [Boolean] :idempotent whether or not the method is idempotent
    # @option options [Boolean] :allows_request_body whether or not the method allows a request body
    # @option options [Boolean] :allows_response_body whether or not the method allows a response body
    def initialize(string, options)
      @string = string
      @safe = options.fetch(:safe)
      @idempotent = options.fetch(:idempotent)
      @allows_request_body = options.fetch(:allows_request_body)
      @allows_response_body = options.fetch(:allows_response_body)
    end

    # Converts the method to a string.
    #
    # @return [String]
    def to_s
      @string
    end

    alias_method :lookup_key, :to_s

    # Returns whether or not the method is safe.
    #
    # @return [Boolean]
    def safe?
      @safe
    end

    # Returns whether or not the method is idempotent.
    #
    # @return [Boolean]
    def idempotent?
      @idempotent
    end

    # Returns whether or not the method allows a request body.
    #
    # @return [Boolean]
    def allows_request_body?
      @allows_request_body
    end

    # Returns whether or not the method allows a response body.
    #
    # @return [Boolean]
    def allows_response_body?
      @allows_response_body
    end

    # Returns whether or not two methods are equal.
    #
    # @param [Method] other the other method
    # @return [Boolean]
    def ==(other)
      to_s == other.to_s &&
        safe? == other.safe? &&
        idempotent? == other.idempotent? &&
        allows_request_body? == other.allows_request_body? &&
        allows_response_body? == other.allows_response_body?
    rescue NoMethodError
      nil
    end

    OPTIONS = register(new("OPTIONS", safe: true,  idempotent: true,  allows_request_body: false, allows_response_body: true))
    GET     = register(new("GET",     safe: true,  idempotent: true,  allows_request_body: false, allows_response_body: true))
    HEAD    = register(new("HEAD",    safe: true,  idempotent: true,  allows_request_body: false, allows_response_body: false))
    POST    = register(new("POST",    safe: false, idempotent: false, allows_request_body: true,  allows_response_body: true))
    PUT     = register(new("PUT",     safe: false, idempotent: true,  allows_request_body: true,  allows_response_body: true))
    DELETE  = register(new("DELETE",  safe: false, idempotent: true,  allows_request_body: false, allows_response_body: true))
    TRACE   = register(new("TRACE",   safe: true,  idempotent: true,  allows_request_body: false, allows_response_body: true))
    CONNECT = register(new("CONNECT", safe: false, idempotent: false, allows_request_body: true,  allows_response_body: true))
    PATCH   = register(new("PATCH",   safe: false, idempotent: false, allows_request_body: true,  allows_response_body: true))
  end
end
