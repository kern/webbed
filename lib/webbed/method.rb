class Webbed::Method
  
  attr_reader :name
  
  def initialize(name, safety = :unsafe, entities = :both_entities)
    @name = name
    @safe = safety == :safe
    @idempotent = [:safe, :idempotent].include? safety
    @has_request_entity = entities == :both_entities
    @has_response_entity = [:both_entities, :only_response_entity].include? entities
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
  
  def to_s
    @name
  end
  
  def ==(other_method)
    name == other_method.to_s
  end
  
  class << self
    def options
      new 'OPTIONS', :safe, :only_response_entity
    end
    
    def get
      new 'GET', :safe, :only_response_entity
    end
    
    def head
      new 'HEAD', :safe, :headers_only
    end
    
    def post
      new 'POST', :unsafe, :both_entities
    end
    
    def put
      new 'PUT', :idempotent, :both_entities
    end
    
    def delete
      new 'DELETE', :idempotent, :only_response_entity
    end
    
    def trace
      new 'TRACE', :safe, :only_response_entity
    end
    
    def connect
      new 'CONNECT', :unsafe, :both_entities
    end
    
    def patch
      new 'PATCH', :unsafe, :both_entities
    end
  end
end