require "webbed/headers"
require "webbed/http_version"
require "webbed/method"
require "addressable/uri"
require "webbed/status_code"

module Webbed
  # `Conversions` contains common conversions to domain objects provided by
  # Webbed. When mixed in to a class, the methods become private methods, so you
  # can safely use these without increasing your class's surface area.
  #
  # @author Alex Kern (alex@kernul)
  # @api public
  module Conversions
    module_function

    # Converts an object to headers.
    #
    # @param [Headers, {String => String}] headers
    # @return [Headers]
    def Headers(headers)
      Headers === headers ? headers : Headers.new(headers)
    end

    # Converts an object to an HTTP version.
    #
    # @param [HTTPVersion, String] http_version
    # @return [HTTPVersion]
    def HTTPVersion(http_version)
      HTTPVersion === http_version ? http_version : HTTPVersion.interpret(http_version)
    end

    # Converts an object to a method.
    #
    # @param [Method, String] method
    # @return [Method]
    def Method(method)
      Method === method ? method : Method.look_up(method)
    end

    # Converts an object to a request URI.
    #
    # This uses the same name as the standard Kernel#URI method but returns the
    # more full-featured implementation of URIs offered by Addressable.
    #
    # @param [Addressable::URI, String] request_uri
    # @return [Addressable::URI]
    def URI(request_uri)
      Addressable::URI === request_uri ? request_uri : Addressable::URI.parse(request_uri)
    end

    # Converts an object to a status code.
    #
    # @param [StatusCode, Fixnum] status_code
    # @return [StatusCode]
    def StatusCode(status_code)
      StatusCode === status_code ? status_code : StatusCode.look_up(status_code)
    end
  end
end
