module Webbed
  class Header
    
    attr_reader :field_name
    attr_accessor :field_value
    alias :field_content= :field_value=
    
    def initialize(field_name, field_value)
      @field_name = field_name
      self.field_value = field_value
    end
    
    def field_content
      field_value.strip
    end
    
    def to_s
      "#{field_name}: #{field_content}"
    end
  end
end