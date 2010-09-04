module Webbed
  class Response
    
    include GenericMessage
    attr_reader :status_code
    attr_writer :reason_phrase
    DEFAULTS = {
      :http_version => 'HTTP/1.1',
      :status_code => 200,
      :reason_phrase => nil,
      :headers => {},
      :entity_body => ''
    }
    
    def initialize(response_hash = {})
      response_hash = DEFAULTS.merge(response_hash)
      
      self.http_version = response_hash[:http_version]
      self.status_code = response_hash[:status_code]
      self.reason_phrase = response_hash[:reason_phrase]
      self.headers.merge!(response_hash[:headers])
      self.entity_body = response_hash[:entity_body]
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