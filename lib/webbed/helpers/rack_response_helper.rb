module Webbed
  module Helpers
    module RackResponseHelper
      def to_rack
        [status_code, headers, entity_body]
      end
      alias :to_a :to_rack
    end
  end
end