require "spec_helper"
require "webbed/method"

module Webbed
  describe Method do
    let(:method) { Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true) }

    it "can be converted to a string representation" do
      method.to_s.should == "GET"
    end

    it "can be safe" do
      method.should be_safe
    end

    it "can be idempotent" do
      method.should be_idempotent
    end

    it "can allow a request entity" do
      method.should_not allow_a_request_entity
    end

    it "can allow a response entity" do
      method.should allow_a_response_entity
    end

    it "uses its string representation as its lookup key" do
      method.lookup_key.should == "GET"
    end

    it "is equal to methods with identical properties" do
      method.should == Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true)
      method.should_not == Method.new("HEAD", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true)
      method.should_not == Method.new("GET", safe: false, idempotent: true, allows_request_entity: false, allows_response_entity: true)
      method.should_not == Method.new("GET", safe: true, idempotent: false, allows_request_entity: false, allows_response_entity: true)
      method.should_not == Method.new("GET", safe: true, idempotent: true, allows_request_entity: true, allows_response_entity: true)
      method.should_not == Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: false)
    end
  end
end
