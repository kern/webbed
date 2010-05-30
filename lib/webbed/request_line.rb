require 'addressable/uri'

module Webbed
  class RequestLine
    
    attr_reader :method, :request_uri
    attr_accessor :http_version
    
    def initialize(method = Webbed::Method::GET,
                   request_uri = '*',
                   http_version = Webbed::HTTPVersion.new)
      self.method = method
      self.request_uri = request_uri
      self.http_version = http_version
    end
    
    def method=(method)
      case method
      when String
        @method = Webbed::Method.const_get(method)
      else
        @method = method
      end
    end
    
    def request_uri=(request_uri)
      case request_uri
      when String
        @request_uri = Addressable::URI.parse(request_uri)
      else
        @request_uri = request_uri
      end
    end
    
    def to_s
      "#{method} #{request_uri} #{http_version}\r\n"
    end
  end
end