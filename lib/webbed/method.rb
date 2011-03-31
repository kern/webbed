module Webbed
  class Method
    attr_reader :allowable_entities
    
    DEFAULTS = {
      :safe => false,
      :idempotent => false,
      :allowable_entities => [:request, :response]
    }
    
    # Creates a new Method unless the Method has been cached.
    # 
    # The standard HTTP methods that are in RFC 2616 as well as the new method
    # PATCH are all cached.
    # 
    # @example
    #   Webbed::Method.new('FAKE') # => New Method called FAKE
    #   Webbed::Method.new('GET') # => Webbed::Method::GET
    # 
    # @param [String] http_version The Method to create
    # @param [Hash] options Options to pass to #initialize
    # @return [Webbed::Method] The new or cached Method
    def self.new(value, options = {})
      if const_defined?(value)
        const_get(value)
      else
        super(value, options)
      end
    end
    
    def initialize(value, options = {})
      options = DEFAULTS.merge(options)
      @value = value
      @safe = options[:safe]
      @idempotent = options[:safe] || options[:idempotent]
      @allowable_entities = options[:allowable_entities]
    end
    
    def safe?
      @safe
    end
    
    def idempotent?
      @idempotent
    end
    
    def to_s
      @value
    end
    
    def ==(other_method)
      to_s == other_method.to_s
    end
    
    # Common methods used and their settings. Most are defined in RFC 2616 with
    # the exception of PATCH which is defined in RFC 5789. These are for caching
    # purposes, so that new objects don't need to be created on each request.
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