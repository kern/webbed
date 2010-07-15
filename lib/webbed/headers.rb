require 'cicphash'

module Webbed
  class Headers < CICPHash
    def initialize(hash = {})
      super
      replace hash
    end
    
    def to_s
      map do |field_name, field_content|
        "#{field_name}: #{self[field_name]}\r\n"
      end.join
    end
  end
end