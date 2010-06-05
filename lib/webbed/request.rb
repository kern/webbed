module Webbed
  class Request
    include Webbed::GenericMessage
    
    def request_line
      @request_line ||= Webbed::RequestLine.new
    end
    alias :start_line :request_line
  end
end