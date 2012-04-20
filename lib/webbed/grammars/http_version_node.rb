module Webbed
  module Grammars
    class HTTPVersionNode < Treetop::Runtime::SyntaxNode
      def major
        major_node.text_value.to_i
      end

      def minor
        minor_node.text_value.to_i
      end
    end
  end
end
