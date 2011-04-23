module Webbed
  # Representation of an HTTP Response
  # 
  # This class contains the absolute minimum for accessing the different parts
  # of an HTTP Response. Helper modules provide far more functionality.
  class Response
    include GenericMessage
    
    # Regular expression for separating a Status Code and a Reason Phrase
    STATUS_CODE_REGEX = /^(\d{3}) (.*)$/
    
    # The Status Code of the Response
    # 
    # The method automatically converts the new value to an instance of
    # {StatusCode} if it is not already one.
    # 
    # @return [#to_i]
    attr_reader :status_code
    
    def status_code=(status_code)
      @status_code = Webbed::StatusCode.new(status_code)
    end
    
    # The Reason Phrase of the Response
    # 
    # The method returns the Status Code's default reason phrase if the Reason
    # Phrase has not already been set.
    # 
    # @return [String]
    def reason_phrase
      @reason_phrase || @status_code.default_reason_phrase
    end
    
    attr_writer :reason_phrase
    
    # Creates a new Response
    # 
    # The attributes of the Response are passed in as an array. In order, they
    # go:
    # 
    # 1. Status Code (and Reason Phrase if a string)
    # 2. Headers
    # 3. Entity Body
    # 
    # The method converts the values passed in to their proper types.
    # 
    # @example
    #     Webbed::Response.new([200, {}, ''])
    #     Webbed::Response.new(['404 Missing File', {}, ''])
    # 
    # @param response_array [Array]
    # @param options [Array] the options to create the Response with
    # @option options :http_version [#to_s] (1.1) the HTTP-Version of the
    #   Response
    def initialize(response_array, options = {})
      self.http_version = options.delete(:http_version) || 1.1
      
      if STATUS_CODE_REGEX =~ response_array[0].to_s
        self.status_code = $1
        self.reason_phrase = $2
      else
        self.status_code = response_array[0]
      end
      
      self.headers = response_array[1]
      self.entity_body = response_array[2]
    end
    
    # The Status-Line of the Response
    # 
    # @example
    #     response = Webbed::Response.new([200, {}, ''])
    #     response.status_line # => "HTTP/1.1 200 OK\r\n"
    # 
    # @return [String]
    def status_line
      "#{http_version} #{status_code} #{reason_phrase}\r\n"
    end
    alias :start_line :status_line
    
    include Helpers::RackResponseHelper
    include Helpers::ResponseHeadersHelper
    include Helpers::EntityHeadersHelper
  end
end