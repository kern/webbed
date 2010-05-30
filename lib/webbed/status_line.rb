module Webbed
  class StatusLine
    
    attr_reader :status_code, :reason_phrase
    attr_accessor :http_version
    
    def initialize(status_code = 200,
                   reason_phrase = nil,
                   http_version = Webbed::HTTPVersion.new)
      self.status_code = status_code
      self.reason_phrase = reason_phrase || status_code
      self.http_version = http_version
    end
    
    def status_code=(status_code)
      @status_code = Webbed::StatusCode.new(status_code)
    end
    
    def reason_phrase=(reason_phrase)
      @reason_phrase = Webbed::ReasonPhrase.new(reason_phrase)
    end
    
    def to_s
      "#{http_version} #{status_code} #{reason_phrase}\r\n"
    end
  end
end