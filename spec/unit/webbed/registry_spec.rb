require "spec_helper"
require "webbed/registry"

module Webbed
  describe Registry do
    let(:obj) { double(:obj, lookup_key: 123) }
    let(:registry) { Class.new { extend(Registry) } }

    before do
      registry.register(obj)
    end

    context "when looking up a registered object" do
      it "finds the object" do
        registry.look_up(123).should == obj
      end
    end

    context "when looking up an unregistered object" do
      it "raises an error" do
        expect do
          registry.look_up(456)
        end.to raise_error(KeyError)
      end
    end

    context "when registering an already registered object" do
      it "overwrites the previous object" do
        new_obj = double(:new_obj, lookup_key: 123)
        registry.register(new_obj)
        registry.look_up(123).should == new_obj
      end
    end
  end
end
