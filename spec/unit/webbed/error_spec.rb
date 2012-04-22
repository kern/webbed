require "spec_helper"
require "webbed/error"

describe Webbed::Error do
  let(:cause) { StandardError.new }
  let(:error) { Webbed::Error.new("test", cause) }
  subject { error }

  it "has a message" do
    subject.message.should == "test"
  end

  it "has a cause" do
    subject.cause.should == cause
  end
end
