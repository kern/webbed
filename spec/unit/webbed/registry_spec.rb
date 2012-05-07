require "spec_helper"
require "webbed/registry"

module Webbed
  describe Registry do
    let(:obj) { stub(lookup_key: 123) }
    subject { Class.new { extend(Registry) } }

    before do
      subject.register(obj)
    end

    context "when looking up a registered object" do
      it "returns the object" do
        subject.look_up(123).should == obj
      end
    end

    context "when looking up an unregistered object" do
      it "raises an error" do
        expect {
          subject.look_up(456)
        }.to raise_error(KeyError)
      end
    end

    context "when registering an already registered object" do
      it "overwrites the previous object" do
        new_obj = stub(lookup_key: 123)
        subject.register(new_obj)
        subject.look_up(123).should == new_obj
      end
    end
  end
end
