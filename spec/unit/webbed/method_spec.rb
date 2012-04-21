require "spec_helper"
require "webbed/method"

describe Webbed::Method do
  let(:method) { Webbed::Method.new("GET", safe: true, idempotent: true, has_request_entity: false, has_response_entity: true) }
  subject { method }

  describe "#initialize" do
    it "sets the string representation of the method" do
      method.to_s.should == "GET"
    end

    it "sets whether or not the method is safe" do
      method.should be_safe
    end

    it "sets whether or not the method is idempotent" do
      method.should be_idempotent
    end

    it "sets whether or not the method has a request entity" do
      method.should_not have_request_entity
    end

    it "sets whether or not the method has a response entity" do
      method.should have_response_entity
    end
  end

  specify "equality" do
    method.should == Webbed::Method.new("GET", safe: true, idempotent: true, has_request_entity: false, has_response_entity: true)
    method.should_not == Webbed::Method.new("HEAD", safe: true, idempotent: true, has_request_entity: false, has_response_entity: true)
    method.should_not == Webbed::Method.new("GET", safe: false, idempotent: true, has_request_entity: false, has_response_entity: true)
    method.should_not == Webbed::Method.new("GET", safe: true, idempotent: false, has_request_entity: false, has_response_entity: true)
    method.should_not == Webbed::Method.new("GET", safe: true, idempotent: true, has_request_entity: true, has_response_entity: true)
    method.should_not == Webbed::Method.new("GET", safe: true, idempotent: true, has_request_entity: false, has_response_entity: false)
  end
end
