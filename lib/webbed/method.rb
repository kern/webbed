module Webbed
  class Method
    DEFAULTS = {
      :safe => false,
      :idempotent => false,
      :allowable_entities => [:request, :response]
    }
    
    # The allowable entities of a message
    # 
    # It can contain any combination of `:request` and `:response`.
    # 
    # @return [Array<:request, :response>]
    attr_reader :allowable_entities
    
    # Checks for a cached Method or creates a new one
    # 
    # It caches the standard HTTP Methods that are in RFC 2616 as well as the
    # new method `PATCH`. If the Method cannot be found, it calls `#initialize`.
    # 
    # @example
    #   Webbed::Method.new('GET') # => Webbed::Method::GET
    # 
    # @param (see #initialize)
    # @return [Method] the new or cached Method
    # @see #initialize
    def self.new(value, options = {})
      if const_defined?(value)
        const_get(value)
      else
        super(value, options)
      end
    end
    
    # Creates a new Method
    # 
    # @param [String] name the name of the Method to create
    # @param [Hash] options the options to create the Method with
    # @option options [Boolean] :safe (false) whether or not the Method is safe
    # @option options [Boolean] :idempotent (false) whether or not the Method is
    #   idempotent
    # @option options [Array<:request, :response>] :allowable_entities
    #   ([:request, :response]) the allowable entites of a message
    def initialize(name, options = {})
      options = DEFAULTS.merge(options)
      @name = name
      @safe = options[:safe]
      @idempotent = options[:safe] || options[:idempotent]
      @allowable_entities = options[:allowable_entities]
    end
    
    # Whether or not the Method is safe
    # 
    # @return [Boolean]
    def safe?
      @safe
    end
    
    # Whether or not the Method is idempotent
    # 
    # @return [Boolean]
    def idempotent?
      @idempotent
    end
    
    # Converts the Method to a string
    # 
    # @return [String]
    def to_s
      @name
    end
    
    # Compares the Method to another Method
    # 
    # Two Methods are equal if they have the same name.
    # 
    # @param [#to_s] other_method the other Method
    # @return [Boolean]
    def ==(other_method)
      to_s == other_method.to_s
    end
    
    OPTIONS = new('OPTIONS', :safe => true,  :idempotent => true,  :allowable_entities => [:response])
    GET     = new('GET',     :safe => true,  :idempotent => true,  :allowable_entities => [:response])
    HEAD    = new('HEAD',    :safe => true,  :idempotent => true,  :allowable_entities => [])
    POST    = new('POST',    :safe => false, :idempotent => false, :allowable_entities => [:request, :response])
    PUT     = new('PUT',     :safe => false, :idempotent => true,  :allowable_entities => [:request, :response])
    DELETE  = new('DELETE',  :safe => false, :idempotent => true,  :allowable_entities => [:response])
    TRACE   = new('TRACE',   :safe => true,  :idempotent => true,  :allowable_entities => [:response])
    CONNECT = new('CONNECT', :safe => false, :idempotent => false, :allowable_entities => [:request, :response])
    PATCH   = new('PATCH',   :safe => false, :idempotent => false, :allowable_entities => [:request, :response])
  end
end
