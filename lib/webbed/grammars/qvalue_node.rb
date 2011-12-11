module Webbed
  module Grammars
    module QvalueNode
      def value
        text_value.to_f
      end
    end
  end
end