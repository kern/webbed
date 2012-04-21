module Webbed
  # `Method` represents an HTTP method (i.e. GET, HEAD, POST).
  class Method
    # Creates a new method.
    #
    # @param [String] the string representation of the method
    # @param [Hash] options miscellaneous options for the method
    # @option options [Boolean] :safe whether or not the method is safe
    # @option options [Boolean] :idempotent whether or not the method is idempotent
    # @option options [Boolean] :has_request_entity whether or not the method has a request entity
    # @option options [Boolean] :has_response_entity whether or not the method has a response entity
    def initialize(string, options)
      @string = string
      @safe = options.fetch(:safe)
      @idempotent = options.fetch(:idempotent)
      @has_request_entity = options.fetch(:has_request_entity)
      @has_response_entity = options.fetch(:has_response_entity)
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

    # Returns whether or not the method has a request entity.
    #
    # @return [Boolean]
    def has_request_entity?
      @has_request_entity
    end

    # Returns whether or not the method has a response entity.
    #
    # @return [Boolean]
    def has_response_entity?
      @has_response_entity
    end

    # Returns whether or not two methods are equal.
    #
    # @param [Webbed::Method] other the other method
    # @return [Boolean]
    def ==(other)
      to_s == other.to_s &&
        safe? == other.safe? &&
        idempotent? == other.idempotent? &&
        has_request_entity? == other.has_request_entity? &&
        has_response_entity? == other.has_response_entity?
    rescue NoMethodError
      nil
    end
  end
end
