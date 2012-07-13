require "spec_helper"
require "webbed/error"

module Webbed
  describe Error do
    let(:cause) { double(:cause) }
    subject(:error) { Webbed::Error.new("test", cause) }

    it "has a message" do
      expect(error.message).to eq("test")
    end

    it "has a cause" do
      expect(error.cause).to eq(cause)
    end
  end
end
