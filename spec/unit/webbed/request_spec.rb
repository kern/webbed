require "spec_helper"
require "addressable/uri"
require "webbed/request"
require "webbed/http_version"

module Webbed
  describe Request do
    let(:method) { double(:method) }
    let(:target) { double(:target) }
    let(:headers) { double(:headers) }
    let(:http_version) { double(:http_version) }
    let(:conversions) { double(:conversions) }
    let(:options) { {} }
    subject(:request) { Request.new("GET", "/", {}, { conversions: conversions }.merge(options)) }

    before do
      conversions.stub(:Method).with("GET") { method }
      conversions.stub(:URI).with("/") { target }
      conversions.stub(:Headers).with({}) { headers }
      conversions.stub(:HTTPVersion).with(HTTPVersion::ONE_POINT_ONE) { HTTPVersion::ONE_POINT_ONE }
      conversions.stub(:HTTPVersion).with("HTTP/1.0") { http_version }
    end

    it "converts the method to an instance of Webbed::Method" do
      expect(request.method).to eq(method)
    end

    it "converts the target to an instance of Addressable::URI" do
      expect(request.target).to eq(target)
    end

    it "converts the headers to an instance of Webbed::Headers" do
      expect(request.headers).to eq(headers)
    end

    context "when not provided with a body" do
      it "has no body" do
        expect(request.body).to be_nil
      end
    end

    context "when provided with a body" do
      let(:options) { { body: ["test"] } }

      it "has a body" do
        expect(request.body).to eq(["test"])
      end
    end

    context "when the request's security has not been specified" do
      it "is unsafe" do
        expect(request).not_to be_secure
      end
    end

    context "when the request's security has been specified" do
      let(:options) { { secure: true } }

      it "uses that security parameter" do
        expect(request).to be_secure
      end
    end
    
    context "when not provided with an HTTP version" do
      it "uses HTTP/1.1" do
        expect(request.http_version).to eq(HTTPVersion::ONE_POINT_ONE)
      end
    end    

    context "when provided with an HTTP version" do
      let(:options) { { http_version: "HTTP/1.0" } }

      it "uses that HTTP version" do
        expect(request.http_version).to eq(http_version)
      end
    end

    it "can recreate the URL of the request" do
      recreator = double(:recreator, recreate: "http://google.com")
      expect(request.url(recreator)).to eq("http://google.com")
    end
  end
end
