require "spec_helper"
require "webbed/method"

module Webbed
  describe Method do
    let(:method) { Method.new("GET", safe: true, idempotent: true, allows_request_body: false, allows_response_body: true) }

    it "can be converted to a string representation" do
      method.to_s.should == "GET"
    end

    it "can be safe" do
      method.should be_safe
    end

    it "can be idempotent" do
      method.should be_idempotent
    end

    it "can allow a request body" do
      method.should_not allow_a_request_body
    end

    it "can allow a response body" do
      method.should allow_a_response_body
    end

    it "uses its string representation as its lookup key" do
      method.lookup_key.should == "GET"
    end

    it "is equal to methods with identical properties" do
      method.should == Method.new("GET", safe: true, idempotent: true, allows_request_body: false, allows_response_body: true)
      method.should_not == Method.new("HEAD", safe: true, idempotent: true, allows_request_body: false, allows_response_body: true)
      method.should_not == Method.new("GET", safe: false, idempotent: true, allows_request_body: false, allows_response_body: true)
      method.should_not == Method.new("GET", safe: true, idempotent: false, allows_request_body: false, allows_response_body: true)
      method.should_not == Method.new("GET", safe: true, idempotent: true, allows_request_body: true, allows_response_body: true)
      method.should_not == Method.new("GET", safe: true, idempotent: true, allows_request_body: false, allows_response_body: false)
    end
  end
end
