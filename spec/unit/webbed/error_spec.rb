require "spec_helper"
require "webbed/error"

module Webbed
  describe Error do
    let(:cause) { double(:cause) }
    let(:error) { Webbed::Error.new("test", cause) }

    it "has a message" do
      error.message.should == "test"
    end

    it "has a cause" do
      error.cause.should == cause
    end
  end
end
