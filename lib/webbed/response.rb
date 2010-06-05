module Webbed
  class Response
    include Webbed::GenericMessage
    
    def status_line
      @status_line ||= Webbed::StatusLine.new
    end
    alias :start_line :status_line
  end
end