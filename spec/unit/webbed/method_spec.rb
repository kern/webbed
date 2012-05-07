require "spec_helper"
require "webbed/method"
require "webbed/unknown_method"

module Webbed
  describe Method do
    subject { Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true) }

    it "can be converted to a string representation" do
      subject.to_s.should == "GET"
    end

    it "can be safe" do
      subject.should be_safe
    end

    it "can be idempotent" do
      subject.should be_idempotent
    end

    it "can allow a request entity" do
      subject.should_not allow_a_request_entity
    end

    it "can allow a response entity" do
      subject.should allow_a_response_entity
    end

    it "uses its string representation as its lookup key" do
      subject.lookup_key.should == "GET"
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
