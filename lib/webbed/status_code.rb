module Webbed
  class StatusCode
    
    attr_reader :status_code
    
    def initialize(status_code)
      @status_code = status_code
    end
    
    def ==(other_status_code)
      status_code == other_status_code
    end
    
    def to_s
      '%03d' % status_code
    end
    
    def informational?
      (100...200).include? status_code
    end
    
    def success?
      (200...300).include? status_code
    end
    
    def redirection?
      (300...400).include? status_code
    end
    
    def client_error?
      (400...500).include? status_code
    end
    
    def server_error?
      (500...600).include? status_code
    end
    
    def unknown?
      !(100...600).include? status_code
    end
    
    def error?
      (400...600).include? status_code
    end
  end
end