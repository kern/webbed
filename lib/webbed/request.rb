require "addressable/uri"
require "webbed/method"
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
    # @return [Webbed::Method]
    attr_reader :method

    def method=(method)
      method = Method.look_up(method) unless Method === method
      @method = method
    end
    
    # Returns the request's request URI.
    #
    # @return [Addressable::URI]
    attr_accessor :request_uri

    def request_uri=(request_uri)
      request_uri = Addressable::URI.parse(request_uri) unless Addressable::URI === request_uri
      @request_uri = request_uri
    end

    # Returns the request's headers.
    #
    # @return [Webbed::Headers]
    attr_reader :headers

    def headers=(headers)
      headers = Headers.new(headers) unless Headers === headers
      @headers = headers
    end

    # Returns the request's entity body.
    #
    # @return [#each, nil]
    attr_accessor :entity_body

    # Returns the request's HTTP version.
    #
    # @return [Webbed::HTTPVersion]
    attr_reader :http_version

    def http_version=(http_version)
      http_version = HTTPVersion.parse(http_version) unless HTTPVersion === http_version
      @http_version = http_version
    end

    # Returns whether or not the request is secure.
    #
    # @return [Boolean]
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
    # @return [Addressable::URI]
    def url
      recreator = URLRecreator.new(self)
      recreator.recreate
    end

    # `URLRecreator` recreates the URL of the request.
    #
    # @author Alex Kern
    # @api private
    class URLRecreator
      # Creates a new URL recreator.
      #
      # @param [Webbed::Request] request the request from which to recreate the URL
      def initialize(request)
        @request = request
      end

      # Returns the recreated URL.
      #
      # @return [Addressable::URI]
      def recreate
        request_uri.dup.tap do |r|
          if !request_uri_has_host? && host_header
            r.scheme = scheme
            r.host = host_header
          end
        end
      end

      private

      # Returns the request URI.
      #
      # @return [Addressable::URI]
      def request_uri
        @request.request_uri
      end

      # Returns the value of the Host header.
      #
      # @return [String, nil]
      def host_header
        @request.headers["Host"]
      end

      # Returns whether or not the request is secure.
      #
      # @return [Boolean]
      def secure?
        @request.secure?
      end

      # Returns the scheme of the request.
      #
      # @return ["http", "https"]
      def scheme
        secure? ? "https" : "http"
      end

      # Returns whether or not the request URI has a host.
      #
      # @return [Boolean]
      def request_uri_has_host?
        request_uri.host
      end
    end
  end
end
