module Webbed
  class Response
    include GenericMessage
    attr_reader :status_code
    attr_writer :reason_phrase
    STATUS_CODE_REGEX = /^(\d{3}) (.*)$/
    
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
    
    def reason_phrase
      @reason_phrase || @status_code.default_reason_phrase
    end
    
    def status_code=(status_code)
      @status_code = Webbed::StatusCode.new(status_code)
    end
    
    def status_line
      "#{http_version} #{status_code} #{reason_phrase}\r\n"
    end
    alias :start_line :status_line
    
    include Helpers::RackResponseHelper
    include Helpers::ResponseHeadersHelper
    include Helpers::EntityHeadersHelper
  end
end