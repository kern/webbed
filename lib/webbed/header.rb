module Webbed
  class Header
    
    attr_accessor :field_name, :field_value
    alias :field_content= :field_value=
    
    def initialize(field_name, field_value)
      self.field_name = field_name
      self.field_value = field_value
    end
    
    def field_content
      field_value.strip
    end
  end
end