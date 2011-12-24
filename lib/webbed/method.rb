module Webbed
  # Representation of an HTTP Method.
  #
  # TODO: Document this class.
  class Method
    class << self
      def registered
        @registered ||= {}
      end

      # Registers a method.
      #
      # @param [Method] method
      def register(method)
        registered[method.name] = method
      end

      # Unregisters a method.
      #
      # @param [Method] method
      def unregister(method)
        registered[method.name] = nil
      end

      # Looks up a registered method by name.
      #
      # @param [String] name
      # @return [Method]
      def lookup(name)
        registered[name]
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

    OPTIONS = register(new("OPTIONS", :safe => true,  :idempotent => true,  :allows_request_entity => false, :allows_response_entity => true))
    GET     = register(new("GET",     :safe => true,  :idempotent => true,  :allows_request_entity => false, :allows_response_entity => true))
    HEAD    = register(new("HEAD",    :safe => true,  :idempotent => true,  :allows_request_entity => false, :allows_response_entity => false))
    POST    = register(new("POST",    :safe => false, :idempotent => false, :allows_request_entity => true,  :allows_response_entity => true))
    PUT     = register(new("PUT",     :safe => false, :idempotent => true,  :allows_request_entity => true,  :allows_response_entity => true))
    DELETE  = register(new("DELETE",  :safe => false, :idempotent => true,  :allows_request_entity => false, :allows_response_entity => true))
    TRACE   = register(new("TRACE",   :safe => true,  :idempotent => true,  :allows_request_entity => false, :allows_response_entity => true))
    CONNECT = register(new("CONNECT", :safe => false, :idempotent => false, :allows_request_entity => true,  :allows_response_entity => true))
    PATCH   = register(new("PATCH",   :safe => false, :idempotent => false, :allows_request_entity => true,  :allows_response_entity => true))
  end
end
