require "spec_helper"
require "webbed/grammars/transform"

module Webbed
  module Grammars
    describe Transform do
      let(:klass) do
        Class.new(Transform) do
          context foo: :foo

          rule(:test1) { foo }
          rule(:test2) { [foo, bar] }
        end
      end

      context "when no context is provided" do
        it "uses the class context" do
          transform = klass.new
          transform.apply(:test1).should == :foo
        end
      end

      context "when an instance context is provided" do
        it "merges the two contexts" do
          transform = klass.new(bar: :bar)
          transform.apply(:test2).should == [:foo, :bar]
        end

        it "overrides the class context" do
          transform = klass.new(foo: :baz, bar: :bar)
          transform.apply(:test2).should == [:baz, :bar]
        end
      end

      context "when an application context is provided" do
        it "merges the two contexts" do
          transform = klass.new
          transform.apply(:test2, bar: :bar).should == [:foo, :bar]
        end

        it "overrides the class and instance contexts" do
          transform = klass.new(bar: :bar)
          transform.apply(:test2, foo: :baz, bar: :qux).should == [:baz, :qux]
        end
      end
    end
  end
end
