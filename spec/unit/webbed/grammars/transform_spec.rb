require "spec_helper"
require "webbed/grammars/transform"

module Webbed
  module Grammars
    describe Transform do
      subject(:klass) do
        Class.new(Transform) do
          context do
            { foo: :foo }
          end

          rule(:test1) { foo }
          rule(:test2) { [foo, bar] }
        end
      end

      context "when no context is provided" do
        it "uses the class context" do
          transform = klass.new
          expect(transform.apply(:test1)).to eq(:foo)
        end
      end

      context "when an instance context is provided" do
        it "merges the two contexts" do
          transform = klass.new(bar: :bar)
          expect(transform.apply(:test2)).to eq([:foo, :bar])
        end

        it "overrides the class context" do
          transform = klass.new(foo: :baz, bar: :bar)
          expect(transform.apply(:test2)).to eq([:baz, :bar])
        end
      end

      context "when an application context is provided" do
        it "merges the two contexts" do
          transform = klass.new
          expect(transform.apply(:test2, bar: :bar)).to eq([:foo, :bar])
        end

        it "overrides the class and instance contexts" do
          transform = klass.new(bar: :bar)
          expect(transform.apply(:test2, foo: :baz, bar: :qux)).to eq([:baz, :qux])
        end
      end
    end
  end
end
