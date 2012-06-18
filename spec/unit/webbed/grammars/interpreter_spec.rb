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
        context "when not given a context" do
          it "interprets the input" do
            parser.stub(:parse).with("foo") { "bar" }
            transform.stub(:apply).with("bar", {}) { "baz" }
            interpreter.interpret("foo").should == "baz"
          end
        end

        context "when given a context" do
          it "interprets the input using that context" do
            parser.stub(:parse).with("foo") { "bar" }
            transform.stub(:apply).with("bar", foo: :bar) { "baz" }
            interpreter.interpret("foo", foo: :bar).should == "baz"
          end
        end
      end
    end
  end
end
