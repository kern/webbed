require "webbed/conversions"
require "webbed/http_version"

module Webbed
  # `Response` represents a single HTTP response.
  #
  # @author Alex Kern
  # @api public
  class Response
    include Conversions

    # Returns the response's status code.
    #
    # @return [StatusCode]
    attr_reader :status_code

    def status_code=(status_code)
      @status_code = StatusCode(status_code)
    end

    # Returns the response's headers.
    #
    # @return [Headers]
    attr_reader :headers

    def headers=(headers)
      @headers = Headers(headers)
    end

    # Returns the response's entity body.
    #
    # @return [#each]
    attr_accessor :entity_body

    # Returns the response's HTTP version.
    #
    # @return [HTTPVersion]
    attr_reader :http_version
 
    def http_version=(http_version)
      @http_version = HTTPVersion(http_version)
    end   

    # Returns the response's reason phrase.
    #
    # @return [String]
    def reason_phrase
      @reason_phrase || status_code.default_reason_phrase
    end
 
    attr_writer :reason_phrase

    # Creates a new response.
    #
    # @param [StatusCode, Fixnum] status_code the response's status code
    # @param [Headers, {String => String}] headers the response's headers
    # @param [#each] entity_body the response's entity body
    # @param [Hash] options miscellaneous options used for some responses
    # @option options [HTTPVersion] :http_version (HTTPVersion::ONE_POINT_ONE) the response's HTTP version
    def initialize(status_code, headers, entity_body, options = {})
      self.status_code = status_code
      self.headers = headers
      self.entity_body = entity_body
      self.http_version = options.fetch(:http_version, HTTPVersion::ONE_POINT_ONE)
      self.reason_phrase = options[:reason_phrase]
    end
  end
end
