require "webbed/status_code"
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
    # @return [Webbed::StatusCode]
    attr_reader :status_code

    def status_code=(status_code)
      status_code = StatusCode.look_up(status_code) unless StatusCode === status_code
      @status_code = status_code
    end

    # Returns the response's headers.
    #
    # @return [Webbed::Headers]
    attr_reader :headers

    def headers=(headers)
      headers = Headers.new(headers) unless Headers === headers
      @headers = headers
    end

    # Returns the response's entity body.
    #
    # @return [#each]
    attr_accessor :entity_body

    # Returns the response's HTTP version.
    #
    # @return [Webbed::HTTPVersion]
    attr_reader :http_version
 
    def http_version=(http_version)
      http_version = HTTPVersion.parse(http_version) unless HTTPVersion === http_version
      @http_version = http_version
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
    # @param [Webbed::StatusCode, Fixnum] status_code the response's status code
    # @param [Webbed::Headers, {String => String}] headers the response's headers
    # @param [#each] entity_body the response's entity body
    # @param [Hash] options miscellaneous options used for some responses
    # @option options [Webbed::HTTPVersion] :http_version (Webbed::HTTPVersion::ONE_POINT_ONE) the response's HTTP version
    def initialize(status_code, headers, entity_body, options = {})
      self.status_code = status_code
      self.headers = headers
      self.entity_body = entity_body
      self.http_version = options.fetch(:http_version, Webbed::HTTPVersion::ONE_POINT_ONE)
      self.reason_phrase = options[:reason_phrase]
    end
  end
end
