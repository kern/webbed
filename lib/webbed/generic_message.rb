module Webbed
  module GenericMessage
    
    attr_writer :entity_body
    alias :body= :entity_body=
    
    # Must be overridden
    def start_line
      "Invalid Start Line\r\n"
    end
    
    def headers
      @headers ||= Webbed::Headers.new
    end
    
    def entity_body
      @entity_body ||= ''
    end
    alias :body :entity_body
    
    def to_s
      "#{start_line}#{headers}\r\n#{entity_body}"
    end
  end
end