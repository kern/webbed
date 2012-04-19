module Webbed
  module Grammars
    module HTTPVersionNode
      def major
        super.to_i
      end

      def minor
        super.to_i
      end
    end
  end
end
