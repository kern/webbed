require "spec_helper"
require "webbed/method"
require "webbed/unknown_method"

module Webbed
  describe Method do
    subject { Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true) }

    describe "#lookup_key" do
      it "returns the string representation" do
        subject.lookup_key.should == "GET"
      end
    end

    it "is equal to methods with identical properties" do
      subject.should == Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true)
      subject.should_not == Method.new("HEAD", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true)
      subject.should_not == Method.new("GET", safe: false, idempotent: true, allows_request_entity: false, allows_response_entity: true)
      subject.should_not == Method.new("GET", safe: true, idempotent: false, allows_request_entity: false, allows_response_entity: true)
      subject.should_not == Method.new("GET", safe: true, idempotent: true, allows_request_entity: true, allows_response_entity: true)
      subject.should_not == Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: false)
    end
  end
end
