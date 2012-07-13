require "spec_helper"
require "parslet"
require "webbed/grammars/interpreter"

module Webbed
  module Grammars
    describe Interpreter do
      let(:parser) { stub(:parser) }
      let(:transform) { stub(:transform) }
      subject(:interpreter) { Interpreter.new(parser, transform) }

      context "when parsing valid input" do
        context "when not given a context" do
          it "interprets the input" do
            parser.stub(:parse).with("foo") { "bar" }
            transform.stub(:apply).with("bar", {}) { "baz" }
            expect(interpreter.interpret("foo")).to eq("baz")
          end
        end

        context "when given a context" do
          it "interprets the input using that context" do
            parser.stub(:parse).with("foo") { "bar" }
            transform.stub(:apply).with("bar", foo: :bar) { "baz" }
            expect(interpreter.interpret("foo", foo: :bar)).to eq("baz")
          end
        end
      end
    end
  end
end
