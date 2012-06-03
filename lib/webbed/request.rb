require "webbed/conversions"
require "webbed/http_version"
require "webbed/url_recreator"

module Webbed
  # `Request` represents a single HTTP request.
  #
  # @author Alex Kern
  # @api public
  class Request
    include Conversions

    # Returns the request's method.
    #
    # @return [Method]
    attr_reader :method

    def method=(method)
      @method = Method(method)
    end
    
    # Returns the request's request URI.
    #
    # @return [Addressable::URI]
    attr_accessor :request_uri

    def request_uri=(request_uri)
      @request_uri = URI(request_uri)
    end

    # Returns the request's headers.
    #
    # @return [Headers]
    attr_reader :headers

    def headers=(headers)
      @headers = Headers(headers)
    end

    # Returns the request's entity body.
    #
    # @return [#each, nil]
    attr_accessor :entity_body

    # Returns the request's HTTP version.
    #
    # @return [HTTPVersion]
    attr_reader :http_version

    def http_version=(http_version)
      @http_version = HTTPVersion(http_version)
    end

    # Returns whether or not the request is secure.
    #
    # @return [Boolean]
    attr_accessor :secure
    alias_method :secure?, :secure

    # Creates a request.
    #
    # @param [Method] method the request's method.
    # @param [Addressable::URI, String] request_uri the request's request URI
    # @param [Headers, {String => String}] headers the request's headers
    # @param [Hash] options miscellaneous options used for some requests
    # @option options [#each] :entity_body (nil) the request's entity body
    # @option options [String, HTTPVersion] :http_version (HTTPVersion::ONE_POINT_ONE) the request's HTTP version
    # @option options [Boolean] :secure (false) whether the request is secure (uses SSL)
    def initialize(method, request_uri, headers, options = {})
      self.method = method
      self.request_uri = request_uri
      self.headers = headers
      self.entity_body = options[:entity_body]
      self.http_version = options.fetch(:http_version, HTTPVersion::ONE_POINT_ONE)
      self.secure = options.fetch(:secure, false)
    end

    # Returns the request's URL.
    #
    # @return [Addressable::URI]
    def url(recreator = URLRecreator.new(self))
      recreator.recreate
    end
  end
end
