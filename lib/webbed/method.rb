module Webbed
  class Method
    
    attr_reader :name
    alias :to_s :name
    DEFAULTS = {
      :safe => false,
      :idempotent => false,
      :entities => [:request, :response]
    }
    
    def self.new(name, options = {})
      if const_defined? name
        return const_get(name)
      end
      
      super(name, options)
    end
    
    def initialize(name, options = {})
      options = DEFAULTS.merge options
      @name = name
      @safe = options[:safe]
      @idempotent = options[:safe] || options[:idempotent]
      @has_request_entity = options[:entities].include? :request
      @has_response_entity = options[:entities].include? :response
    end
    
    def safe?
      @safe
    end
    
    def idempotent?
      @idempotent
    end
    
    def has_request_entity?
      @has_request_entity
    end
    
    def has_response_entity?
      @has_response_entity
    end
    
    def ==(other_method)
      name == other_method.to_s
    end
    
    # Common methods used and their settings. Most are defined in RFC 2616 with the exception of PATCH
    # which is defined in RFC 5789. These are for caching purposes, so that new objects don't need to
    # be created on each request.
    OPTIONS = new 'OPTIONS', :safe => true,  :idempotent => true,  :entities => [:response]
    GET     = new 'GET',     :safe => true,  :idempotent => true,  :entities => [:response]
    HEAD    = new 'HEAD',    :safe => true,  :idempotent => true,  :entities => []
    POST    = new 'POST',    :safe => false, :idempotent => false, :entities => [:request, :response]
    PUT     = new 'PUT',     :safe => false, :idempotent => true,  :entities => [:request, :response]
    DELETE  = new 'DELETE',  :safe => false, :idempotent => true,  :entities => [:response]
    TRACE   = new 'TRACE',   :safe => true,  :idempotent => true,  :entities => [:response]
    CONNECT = new 'CONNECT', :safe => false, :idempotent => false, :entities => [:request, :response]
    PATCH   = new 'PATCH',   :safe => false, :idempotent => false, :entities => [:request, :response]
  end
end