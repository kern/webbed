require "addressable/uri"
require "webbed/headers"
require "webbed/http_version"

module Webbed
  # `Request` represents a single HTTP request.
  #
  # @author Alex Kern
  # @api public
  class Request
    # Returns the request's method.
    #
    # @return [Webbed::Method] the request's method
    attr_accessor :method
    
    # Returns the request's request URI.
    #
    # @return [Addressable::URI] the request's request URI
    attr_accessor :request_uri

    def request_uri=(request_uri)
      if Addressable::URI === request_uri
        @request_uri = request_uri
      else
        @request_uri = Addressable::URI.parse(request_uri)
      end
    end

    # Returns the request's headers.
    #
    # @return [Webbed::Headers] the request's headers
    attr_reader :headers

    def headers=(headers)
      if Headers === headers
        @headers = headers
      else
        @headers = Headers.new(headers)
      end
    end

    # Returns the request's entity body.
    #
    # @return [#each, nil] the request's entity body
    attr_accessor :entity_body

    # Returns the request's HTTP version.
    #
    # @return [Webbed::HTTPVersion] the request's HTTP version
    attr_accessor :http_version

    # Returns whether the request is secure.
    #
    # @return [Boolean] whether the request is secure
    attr_accessor :secure
    alias_method :secure?, :secure

    # Creates a request.
    #
    # @param [Webbed::Method] method the request's method.
    # @param [Addressable::URI, String] request_uri the request's request URI
    # @param [Webbed::Headers, {String => String}] headers the request's headers
    # @param [Hash] options miscellaneous options used for some requests
    # @option options [#each] :entity_body (nil) the request's entity body
    # @option options [Webbed::HTTPVersion] :http_version (Webbed::HTTPVersion::ONE_POINT_ONE) the request's HTTP version
    # @option options [Boolean] :secure (false) whether the request is secure (uses SSL)
    def initialize(method, request_uri, headers, options = {})
      self.method = method
      self.request_uri = request_uri
      self.headers = headers
      self.entity_body = options[:entity_body]
      self.http_version = options.fetch(:http_version, "HTTP/1.1")
      self.secure = options.fetch(:secure, false)
    end

    # Returns the request's URL.
    #
    # If the request URI is an absolute path, this method returns the request
    # URI. Otherwise, if the Host header is present, this method returns a
    # modified request URI that uses the Host header and whether the request is
    # secure. If the Host header is not present, this method returns the
    # request URI untouched.
    #
    # @return [Addressable::URI] the request's URL
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
