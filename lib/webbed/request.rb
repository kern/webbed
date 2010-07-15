require 'addressable/uri'

module Webbed
  class Request
    
    include Webbed::GenericMessage
    attr_reader :request_uri, :entity_body
    DEFAULTS = {
      :method => 'GET',
      :request_uri => '*',
      :http_version => 'HTTP/1.1',
      :headers => {},
      :entity_body => ''
    }
    
    def initialize(request_hash = {})
      request_hash = DEFAULTS.merge(request_hash)
      
      self.method = request_hash[:method]
      self.request_uri = request_hash[:request_uri]
      self.http_version = request_hash[:http_version]
      self.headers.merge!(request_hash[:headers])
      self.entity_body = request_hash[:entity_body]
    end
    
    def method(*args)
      return super(*args) unless args.empty?
      @method
    end
    
    def method=(method)
      @method = Webbed::Method.new(method)
    end
    
    def request_uri=(uri)
      @request_uri = Addressable::URI.parse(uri)
    end
    
    def request_line
      "#{method} #{request_uri} #{http_version}\r\n"
    end
    alias :start_line :request_line
  end
end