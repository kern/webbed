require 'test_helper'

module WebbedTest
  module GrammarTest
    class CharsetTest < TestCase
      def setup
        @parser = Webbed::Grammars::CharsetParser.new
      end

      test 'parse a charset' do
        charset = @parser.parse('hello').value
        assert_equal 'hello', charset.to_s
      end
    end
  end
end