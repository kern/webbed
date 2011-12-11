module Webbed
  # Representation of an HTTP Method.
  class Method
    class << self
      # The registered Methods.
      #
      # @return [{String => Method}]
      def registered
        @registered ||= {}
      end

      # Registers a new Method.
      #
      # @example
      #   Webbed::Method.register('GET') # => Webbed::Method::GET
      #
      # @param (see #initialize)
      # @return [Method] the registered Method
      # @see #initialize
      def register(*args)
        registered[args[0]] = new(*args)
      end

      # Looks up the registered Method or returns a temporary one.
      #
      # @param [String] name the name of the Method
      # @return [Method] the registered or temporary Method
      def lookup(name)
        registered[name] || new(name)
      end
    end

    # Returns the method's name.
    #
    # @return [String]
    attr_reader :name

    # Creates a new method.
    #
    # @param [String] name
    # @param [Hash] options
    # @option options [Boolean] :safe whether or not the method is safe
    # @option options [Boolean] :idempotent whether or not the method is idempotent
    # @option options [Boolean] :allows_request_entity whether or not the method allows a request entity
    # @option options [Boolean] :allows_response_entity whether or not the method allows a response entity
    def initialize(name, options)
      @name = name
      @safe = options.fetch(:safe)
      @idempotent = options.fetch(:idempotent)
      @allows_request_entity = options.fetch(:allows_request_entity)
      @allows_response_entity = options.fetch(:allows_response_entity)
    end

    # Determines if the method is safe.
    #
    # @return [Boolean]
    def safe?
      @safe
    end

    # Determines if the method is idempotent.
    #
    # @return [Boolean]
    def idempotent?
      @idempotent
    end

    # Determines if request entities are allowed.
    #
    # @return [Boolean]
    def allows_request_entity?
      @allows_request_entity
    end

    # Determines if response entities are allowed.
    #
    # @return [Boolean]
    def allows_response_entity?
      @allows_response_entity
    end

    # Determines if two methods are equal.
    #
    # This implementation of equality is rather naive. This method only checks
    # if the names of the two methods are equal, but does not care about
    # attributes such as safety and idempotency.
    #
    # @param [Method] other
    # @return [Boolean]
    def ==(other)
      @name == other.name
    end

    OPTIONS = register("OPTIONS", :safe => true,  :idempotent => true,  :allows_request_entity => false, :allows_response_entity => true)
    GET     = register("GET",     :safe => true,  :idempotent => true,  :allows_request_entity => false, :allows_response_entity => true)
    HEAD    = register("HEAD",    :safe => true,  :idempotent => true,  :allows_request_entity => false, :allows_response_entity => false)
    POST    = register("POST",    :safe => false, :idempotent => false, :allows_request_entity => true,  :allows_response_entity => true)
    PUT     = register("PUT",     :safe => false, :idempotent => true,  :allows_request_entity => true,  :allows_response_entity => true)
    DELETE  = register("DELETE",  :safe => false, :idempotent => true,  :allows_request_entity => false, :allows_response_entity => true)
    TRACE   = register("TRACE",   :safe => true,  :idempotent => true,  :allows_request_entity => false, :allows_response_entity => true)
    CONNECT = register("CONNECT", :safe => false, :idempotent => false, :allows_request_entity => true,  :allows_response_entity => true)
    PATCH   = register("PATCH",   :safe => false, :idempotent => false, :allows_request_entity => true,  :allows_response_entity => true)
  end
end
