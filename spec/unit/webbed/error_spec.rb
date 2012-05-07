require "spec_helper"
require "webbed/error"

module Webbed
  describe Error do
    let(:cause) { stub(:cause) }
    subject { Webbed::Error.new("test", cause) }

    it "has a message" do
      subject.message.should == "test"
    end

    it "has a cause" do
      subject.cause.should == cause
    end
  end
end
