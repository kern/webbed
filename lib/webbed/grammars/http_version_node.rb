module Webbed
  module Grammars
    module HTTPVersionNode
      def value
        [major.value, minor.value]
      end
    end
  end
end
