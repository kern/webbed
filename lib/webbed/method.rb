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
    # @param [String] the string representation of the method
    # @param [Hash] options miscellaneous options for the method
    # @option options [Boolean] :safe whether or not the method is safe
    # @option options [Boolean] :idempotent whether or not the method is idempotent
    # @option options [Boolean] :allows_request_entity whether or not the method allows a request entity
    # @option options [Boolean] :allows_response_entity whether or not the method allows a response entity
    def initialize(string, options)
      @string = string
      @safe = options.fetch(:safe)
      @idempotent = options.fetch(:idempotent)
      @allows_request_entity = options.fetch(:allows_request_entity)
      @allows_response_entity = options.fetch(:allows_response_entity)
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

    # Returns whether or not the method allows a request entity.
    #
    # @return [Boolean]
    def allows_request_entity?
      @allows_request_entity
    end

    # Returns whether or not the method allows a response entity.
    #
    # @return [Boolean]
    def allows_response_entity?
      @allows_response_entity
    end

    # Returns whether or not two methods are equal.
    #
    # @param [Webbed::Method] other the other method
    # @return [Boolean]
    def ==(other)
      to_s == other.to_s &&
        safe? == other.safe? &&
        idempotent? == other.idempotent? &&
        allows_request_entity? == other.allows_request_entity? &&
        allows_response_entity? == other.allows_response_entity?
    rescue NoMethodError
      nil
    end

    OPTIONS = register(new("OPTIONS", safe: true,  idempotent: true,  allows_request_entity: false, allows_response_entity: true))
    GET     = register(new("GET",     safe: true,  idempotent: true,  allows_request_entity: false, allows_response_entity: true))
    HEAD    = register(new("HEAD",    safe: true,  idempotent: true,  allows_request_entity: false, allows_response_entity: false))
    POST    = register(new("POST",    safe: false, idempotent: false, allows_request_entity: true,  allows_response_entity: true))
    PUT     = register(new("PUT",     safe: false, idempotent: true,  allows_request_entity: true,  allows_response_entity: true))
    DELETE  = register(new("DELETE",  safe: false, idempotent: true,  allows_request_entity: false, allows_response_entity: true))
    TRACE   = register(new("TRACE",   safe: true,  idempotent: true,  allows_request_entity: false, allows_response_entity: true))
    CONNECT = register(new("CONNECT", safe: false, idempotent: false, allows_request_entity: true,  allows_response_entity: true))
    PATCH   = register(new("PATCH",   safe: false, idempotent: false, allows_request_entity: true,  allows_response_entity: true))
  end
end
