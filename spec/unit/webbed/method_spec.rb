require "spec_helper"
require "webbed/method"

module Webbed
  describe Method do
    subject(:method) { Method.new("GET", safe: true, idempotent: true, allows_request_body: false, allows_response_body: true) }

    it_behaves_like "a registry" do
      subject(:registry) { Method }
      let(:lookup_key) { "GET" }
      let(:obj1) { double(:method_1, to_s: "GET") }
      let(:obj2) { double(:method_2, to_s: "GET") }
    end

    it "can be converted to a string representation" do
      expect(method.to_s).to eq("GET")
    end

    it "can be safe" do
      expect(method).to be_safe
    end

    it "can be idempotent" do
      expect(method).to be_idempotent
    end

    it "can allow a request body" do
      expect(method).not_to allow_a_request_body
    end

    it "can allow a response body" do
      expect(method).to allow_a_response_body
    end

    it "is equal to methods with identical properties" do
      expect(method).to eq(Method.new("GET", safe: true, idempotent: true, allows_request_body: false, allows_response_body: true))
      expect(method).not_to eq(Method.new("HEAD", safe: true, idempotent: true, allows_request_body: false, allows_response_body: true))
      expect(method).not_to eq(Method.new("GET", safe: false, idempotent: true, allows_request_body: false, allows_response_body: true))
      expect(method).not_to eq(Method.new("GET", safe: true, idempotent: false, allows_request_body: false, allows_response_body: true))
      expect(method).not_to eq(Method.new("GET", safe: true, idempotent: true, allows_request_body: true, allows_response_body: true))
      expect(method).not_to eq(Method.new("GET", safe: true, idempotent: true, allows_request_body: false, allows_response_body: false))
    end
  end
end
