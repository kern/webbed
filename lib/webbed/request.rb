require "webbed/conversions"
require "webbed/http_version"
require "webbed/url_recreator"

module Webbed
  # `Request` represents a single HTTP request.
  #
  # @author Alexander Simon Kern (alex@kernul.com)
  # @api public
  class Request
    extend Forwardable

    # Returns the request's method.
    #
    # @return [Method]
    attr_reader :method

    def method=(method)
      @method = Method(method)
    end
    
    # Returns the request's target.
    #
    # @return [Addressable::URI]
    attr_accessor :target

    def target=(target)
      @target = URI(target)
    end

    # Returns the request's headers.
    #
    # @return [Headers]
    attr_reader :headers

    def headers=(headers)
      @headers = Headers(headers)
    end

    # Returns the request's body.
    #
    # @return [#each, nil]
    attr_accessor :body

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
    # @param [Addressable::URI, String] target the request's target
    # @param [Headers, {String => String}] headers the request's headers
    # @param [Hash] options miscellaneous options used for some requests
    # @option options [Object] :conversions (Conversions) the module that implements conversions
    # @option options [#each] :body (nil) the request's body
    # @option options [String, HTTPVersion] :http_version (HTTPVersion::ONE_POINT_ONE) the request's HTTP version
    # @option options [Boolean] :secure (false) whether the request is secure (uses SSL)
    def initialize(method, target, headers, options = {})
      @conversions = options.fetch(:conversions, Conversions)

      self.method = method
      self.target = target
      self.headers = headers
      self.body = options[:body]
      self.http_version = options.fetch(:http_version, HTTPVersion::ONE_POINT_ONE)
      self.secure = options.fetch(:secure, false)
    end

    # Returns the request's URL.
    #
    # @return [Addressable::URI]
    def url(recreator = URLRecreator.new(self))
      recreator.recreate
    end

    private

    delegate [:Method, :URI, :Headers, :HTTPVersion] => :@conversions
  end
end
