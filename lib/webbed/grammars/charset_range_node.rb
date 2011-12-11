module Webbed
  module Grammars
    module CharsetRangeNode
      def value
        quality = qparam.empty? ? nil : qparam.value
        Webbed::CharsetRange.new(range.text_value, :quality => quality)
      end
    end
  end
end