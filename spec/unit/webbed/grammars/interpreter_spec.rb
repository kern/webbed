require "spec_helper"
require "parslet"
require "webbed/grammars/interpreter"

module Webbed
  module Grammars
    describe Interpreter do
      let(:parser) { stub(:parser) }
      let(:transform) { stub(:transform) }
      let(:interpreter) { Interpreter.new(parser, transform) }

      context "when parsing valid input" do
        it "interprets the input" do
          parser.stub(:parse).with("foo") { "bar" }
          transform.stub(:apply).with("bar") { "baz" }
          interpreter.interpret("foo").should == "baz"
        end
      end

      context "when parsing invalid input" do
        it "raises an error" do
          parser.stub(:parse).with("foo") { raise Parslet::ParseFailed, "foo" }
          expect do
            interpreter.interpret("foo")
          end.to raise_error(InvalidFormat)
        end
      end
    end
  end
end
