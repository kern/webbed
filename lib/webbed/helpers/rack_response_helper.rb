module Webbed
  module Helpers
    module RackResponseHelper
      def to_rack
        [status_code, headers, entity_body]
      end
      
      def to_a
        ["#{status_code} #{reason_phrase}", headers, entity_body]
      end
    end
  end
end