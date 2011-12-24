module Webbed
  module Grammars
    module HTTPMajorVersionNode
      def value
        text_value.to_i
      end
    end
  end
end
