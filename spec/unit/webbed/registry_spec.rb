require "spec_helper"
require "webbed/registry"

describe Webbed::Registry do
  let(:obj) { stub(lookup_key: 123) }
  let(:registry) { Class.new { extend(Webbed::Registry) } }
  subject { registry }

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
    let(:new_obj) { stub(lookup_key: 123) }

    before do
      subject.register(new_obj)
    end

    it "overwrites the previous object" do
      subject.look_up(123).should == new_obj
    end
  end
end
