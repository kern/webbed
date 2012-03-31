require "addressable/uri"
require "webbed/headers"

module Webbed
  class Request
    attr_accessor :method

    attr_accessor :request_uri

    attr_reader :headers

    attr_accessor :entity_body

    attr_accessor :http_version

    attr_writer :secure

    def initialize(method, request_uri, headers, options = {})
      self.method = method
      self.request_uri = request_uri
      self.headers = headers
      self.entity_body = options[:entity_body]
      self.http_version = options.fetch(:http_version, "HTTP/1.1")
      self.secure = options.fetch(:secure, false)
    end

    def request_uri=(request_uri)
      if Addressable::URI === request_uri
        @request_uri = request_uri
      else
        @request_uri = Addressable::URI.parse(request_uri)
      end
    end

    def headers=(headers)
      if Headers === headers
        @headers = headers
      else
        @headers = Headers.new(headers)
      end
    end

    def secure?
      @secure
    end

    def url
      result = request_uri.dup
      if !result.host && headers.has_key?("Host")
        result.scheme = secure? ? "https" : "http"
        result.host = headers["Host"]
      end

      result
    end
  end
end
