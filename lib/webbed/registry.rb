module Webbed
  # `Registry` provides a consistent interface to create object registries.
  #
  # @author Alexander Simon Kern (alex@kernul)
  # @api public
  class Registry
    # Creates a new registry.
    #
    # @param [#call] lookup_key_fetcher a lambda called on registered objects to retrieve their lookup keys
    def initialize(&lookup_key_fetcher)
      @lookup_key_fetcher = lookup_key_fetcher
      @registry = {}
    end

    # Registers a method by its lookup key.
    #
    # @param [Object] obj the object to register
    def register(obj)
      @registry[@lookup_key_fetcher.call(obj)] = obj
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
    # @return [Object]
    # @raise [IndexError] if the object could not be found
    def look_up(lookup_key)
      @registry.fetch(lookup_key)
    end
  end
end
