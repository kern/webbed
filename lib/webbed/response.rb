require "webbed/headers"
require "webbed/http_version"

module Webbed
  # `Response` represents a single HTTP response.
  #
  # @author Alex Kern
  # @api public
  class Response
    # Returns the response's status code.
    #
    # @return [Webbed::StatusCode] the response's status code
    attr_accessor :status_code

    # Returns the response's headers.
    #
    # @return [Webbed::Headers] the response's headers
    attr_reader :headers

    def headers=(headers)
      headers = Headers.new(headers) unless Headers === headers
      @headers = headers
    end

    # Returns the response's entity body.
    #
    # @return [#each] the response's entity body
    attr_accessor :entity_body

    # Returns the response's HTTP version.
    #
    # @return [Webbed::HTTPVersion] the response's HTTP version
    attr_reader :http_version
 
    def http_version=(http_version)
      http_version = HTTPVersion.parse(http_version) unless HTTPVersion === http_version
      @http_version = http_version
    end   

    # Creates a new response.
    #
    # @param [Webbed::StatusCode, Fixnum] status_code the response's status code
    # @param [Webbed::Headers, {String => String}] headers the response's headers
    # @param [#each] entity_body the response's entity body
    # @param [Hash] options miscellaneous options used for some responses
    def initialize(status_code, headers, entity_body, options = {})
      self.status_code = status_code
      self.headers = headers
      self.entity_body = entity_body
      self.http_version = options.fetch(:http_version, Webbed::HTTPVersion::ONE_POINT_ONE)
    end
  end
end
