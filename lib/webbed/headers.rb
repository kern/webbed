require 'cicphash'

module Webbed
  class Headers < CICPHash
    def initialize(hash = {})
      super
      replace hash
    end
    
    def add(field_name, field_value)
      if has_key? field_name
        self[field_name] += ",#{field_value.strip}"
      else
        self[field_name] = field_value.strip
      end
    end
    
    def []=(field_name, field_value)
      super(field_name, field_value.strip)
    end
    
    def to_s
      map do |field_name, field_content|
        "#{field_name}: #{self[field_name]}\r\n"
      end.join
    end
  end
end