require "spec_helper"
require "webbed/method"
require "webbed/unknown_method"

describe Webbed::Method do
  let(:method) { Webbed::Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true) }
  subject { method }

  describe "#initialize" do
    it "sets the string representation of the method" do
      subject.to_s.should == "GET"
    end

    it "sets whether or not the method is safe" do
      subject.should be_safe
    end

    it "sets whether or not the method is idempotent" do
      subject.should be_idempotent
    end

    it "sets whether or not the method allows a request entity" do
      subject.should_not allow_a_request_entity
    end

    it "sets whether or not the method allows a response entity" do
      subject.should allow_a_response_entity
    end
  end

  describe "#lookup_key" do
    it "returns the string representation" do
      subject.lookup_key.should == "GET"
    end
  end

  specify "equality" do
    subject.should == Webbed::Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true)
    subject.should_not == Webbed::Method.new("HEAD", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true)
    subject.should_not == Webbed::Method.new("GET", safe: false, idempotent: true, allows_request_entity: false, allows_response_entity: true)
    subject.should_not == Webbed::Method.new("GET", safe: true, idempotent: false, allows_request_entity: false, allows_response_entity: true)
    subject.should_not == Webbed::Method.new("GET", safe: true, idempotent: true, allows_request_entity: true, allows_response_entity: true)
    subject.should_not == Webbed::Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: false)
  end
end
