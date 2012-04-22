require "webbed/unknown_method"

module Webbed
  # `Method` represents an HTTP method (i.e. GET, HEAD, POST).
  #
  # @author Alex Kern
  # @api public
  class Method
    @registered_methods = {}

    # Registers a method by its string representation.
    #
    # The method can be retrieved by its string representation at a later date
    # using {#lookup}.
    #
    # @param [Webbed::Method] method the method to register
    def self.register(method)
      @registered_methods[method.to_s] = method
    end

    # Unregisters a method by its string representation.
    #
    # @param [Webbed::Method] method the method to unregister
    def self.unregister(method)
      @registered_methods.delete(method)
    end

    # Looks up a method by its string representation.
    #
    # @param [String] string the string representation to look up
    # @return [Webbed::Method]
    # @raises [Webbed::UnknownMethod] if the method could not be found
    def self.look_up(string)
      @registered_methods.fetch(string)
    rescue KeyError => e
      raise UnknownMethod.new(nil, e)
    end

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

    OPTIONS = register(Webbed::Method.new("OPTIONS", safe: true,  idempotent: true,  allows_request_entity: false, allows_response_entity: true))
    GET     = register(Webbed::Method.new("GET",     safe: true,  idempotent: true,  allows_request_entity: false, allows_response_entity: true))
    HEAD    = register(Webbed::Method.new("HEAD",    safe: true,  idempotent: true,  allows_request_entity: false, allows_response_entity: false))
    POST    = register(Webbed::Method.new("POST",    safe: false, idempotent: false, allows_request_entity: true,  allows_response_entity: true))
    PUT     = register(Webbed::Method.new("PUT",     safe: false, idempotent: true,  allows_request_entity: true,  allows_response_entity: true))
    DELETE  = register(Webbed::Method.new("DELETE",  safe: false, idempotent: true,  allows_request_entity: false, allows_response_entity: true))
    TRACE   = register(Webbed::Method.new("TRACE",   safe: true,  idempotent: true,  allows_request_entity: false, allows_response_entity: true))
    CONNECT = register(Webbed::Method.new("CONNECT", safe: false, idempotent: false, allows_request_entity: true,  allows_response_entity: true))
    PATCH   = register(Webbed::Method.new("PATCH",   safe: false, idempotent: false, allows_request_entity: true,  allows_response_entity: true))
  end
end
