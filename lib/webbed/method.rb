module Webbed
  # Representation of an HTTP Method.
  class Method
    DEFAULTS = {
      :safe => false,
      :idempotent => false,
      :allowable_entities => [:request, :response]
    }
    
    # The allowable entities of a message.
    # 
    # It can contain any combination of `:request` and `:response`.
    # 
    # @return [Array<:request, :response>]
    attr_reader :allowable_entities
    
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
    
    # Creates a new Method.
    # 
    # @param [String] name the name of the Method to create
    # @param [Hash] options the options to create the Method with
    # @option options [Boolean] :safe (false) whether or not the Method is safe
    # @option options [Boolean] :idempotent (false) whether or not the Method is idempotent
    # @option options [Array<:request, :response>] :allowable_entities ([:request, :response]) the allowable entites of a message
    def initialize(name, options = {})
      options = DEFAULTS.merge(options)
      @name = name
      @safe = options[:safe]
      @idempotent = options[:safe] || options[:idempotent]
      @allowable_entities = options[:allowable_entities]
    end
    
    # Whether or not the Method is safe.
    # 
    # @return [Boolean]
    def safe?
      @safe
    end
    
    # Whether or not the Method is idempotent.
    # 
    # @return [Boolean]
    def idempotent?
      @idempotent
    end
    
    # Converts the Method to a string.
    # 
    # @return [String]
    def to_s
      @name
    end
    
    # Compares the Method to another Method.
    # 
    # Two Methods are equal if they have the same name.
    # 
    # @param [#to_s] other_method the other Method
    # @return [Boolean]
    def ==(other_method)
      to_s == other_method.to_s
    end
    
    OPTIONS = register('OPTIONS', :safe => true,  :idempotent => true,  :allowable_entities => [:response])
    GET     = register('GET',     :safe => true,  :idempotent => true,  :allowable_entities => [:response])
    HEAD    = register('HEAD',    :safe => true,  :idempotent => true,  :allowable_entities => [])
    POST    = register('POST',    :safe => false, :idempotent => false, :allowable_entities => [:request, :response])
    PUT     = register('PUT',     :safe => false, :idempotent => true,  :allowable_entities => [:request, :response])
    DELETE  = register('DELETE',  :safe => false, :idempotent => true,  :allowable_entities => [:response])
    TRACE   = register('TRACE',   :safe => true,  :idempotent => true,  :allowable_entities => [:response])
    CONNECT = register('CONNECT', :safe => false, :idempotent => false, :allowable_entities => [:request, :response])
    PATCH   = register('PATCH',   :safe => false, :idempotent => false, :allowable_entities => [:request, :response])
  end
end
