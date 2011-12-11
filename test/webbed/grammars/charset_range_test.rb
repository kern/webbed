require 'test_helper'

module WebbedTest
  module GrammarTest
    class CharsetRangeTest < TestCase
      def setup
        @parser = Webbed::Grammars::CharsetRangeParser.new
      end

      test 'parse a charset without a quality' do
        range = @parser.parse('hello').value
        assert_equal 'hello', range.to_s
        assert_equal 1.0, range.quality
      end
      
      test 'parse a charset with a quality' do
        range = @parser.parse('hello; q=0.5').value
        assert_equal 'hello; q=0.5', range.to_s
        assert_equal 0.5, range.quality
      end
    end
  end
end