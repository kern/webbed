module Webbed
  module Grammars
    module CharsetNode
      def value
        Webbed::Charset.new(text_value)
      end
    end
  end
end