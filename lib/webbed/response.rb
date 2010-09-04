module Webbed
  class Response
    
    include GenericMessage
    attr_reader :status_code
    attr_writer :reason_phrase
    STATUS_CODE_REGEX = /^(\d{3}) (.*)$/
    
    def initialize(response_array)
      self.http_version = response_array[0]
      
      if response_array[1].respond_to?(:match)
        match = response_array[1].match STATUS_CODE_REGEX
        self.status_code = match[1]
        self.reason_phrase = match[2]
      else
        self.status_code = response_array[1]
      end
      
      self.headers = response_array[2]
      self.entity_body = response_array[3]
    end
    
    def reason_phrase
      @reason_phrase || default_reason_phrase
    end
    
    def default_reason_phrase
      @status_code.default_reason_phrase
    end
    
    def status_code=(status_code)
      @status_code = Webbed::StatusCode.new(status_code)
    end
    
    def status_line
      "#{http_version} #{status_code} #{reason_phrase}\r\n"
    end
    alias :start_line :status_line
    
    # Helpers
    include Helpers::RackResponseHelper
    
  end
end