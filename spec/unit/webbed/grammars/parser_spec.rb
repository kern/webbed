require "spec_helper"
require "webbed/grammars/parser"
require "webbed/parse_failed"

module Webbed
  module Grammars
    describe Parser do
      let(:klass) do
        Class.new(Parser) do
          rule(:foo) { str("foo") }
          root(:foo)
        end
      end

      let(:parser) { klass.new }

      context "when there is a parse failure" do
        it "raises an error" do
          expect do
            parser.parse("foobar")
          end.to raise_error(ParseFailed)
        end
      end
    end
  end
end
