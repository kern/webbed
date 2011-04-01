module Webbed
  module Helpers
    module RackResponseHelper
      def to_rack
        if entity_body.respond_to?(:each)
          [status_code, headers, entity_body]
        else
          [status_code, headers, [entity_body]]
        end
      end
      
      def to_a
        ["#{status_code} #{reason_phrase}", headers, entity_body]
      end
    end
  end
end