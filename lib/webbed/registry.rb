module Webbed
  # `Registry` provides a consistent interface to create object registries.
  # Classes that extend this class must have an instance method named
  # `#lookup_key` for the objects that they register.
  #
  # @author Alex Kern
  # @api public
  module Registry
    def self.extended(base)
      base.class_eval do
        @registry = {}
      end
    end

    # Registers a method by its lookup key.
    #
    # @param [#lookup_key] obj the object to register
    def register(obj)
      @registry[obj.lookup_key] = obj
    end

    # Unregisters an object by its lookup key.
    #
    # @param [Object] lookup_key the lookup key to unregister
    def unregister(lookup_key)
      @registry.delete(lookup_key)
    end

    # Looks up an object by its lookup key.
    #
    # @param [Object] lookup_key the lookup key
    # @return [#lookup_key]
    # @raise [KeyError] if the object could not be found
    def look_up(lookup_key)
      @registry.fetch(lookup_key)
    end
  end
end
