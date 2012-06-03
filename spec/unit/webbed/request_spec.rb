require "spec_helper"
require "addressable/uri"
require "webbed/request"
require "webbed/http_version"

module Webbed
  describe Request do
    let(:method) { double(:method) }
    let(:target) { double(:target) }
    let(:headers) { double(:headers) }
    let(:options) { {} }
    let(:request) { Request.new("GET", "/", {}, options) }

    before do
      Method.stub(:look_up).with("GET") { method }
      Addressable::URI.stub(:parse).with("/") { target }
      Headers.stub(:new).with({}) { headers }
    end

    it "converts the method to an instance of Webbed::Method" do
      request.method.should == method
    end

    it "converts the target to an instance of Addressable::URI" do
      request.target.should == target
    end

    it "converts the headers to an instance of Webbed::Headers" do
      request.headers.should == headers
    end

    context "when not provided with a body" do
      it "has no body" do
        request.body.should be_nil
      end
    end

    context "when provided with a body" do
      let(:options) { { body: ["test"] } }

      it "has a body" do
        request.body.should == ["test"]
      end
    end

    context "when the request's security has not been specified" do
      it "is unsafe" do
        request.should_not be_secure
      end
    end

    context "when the request's security has been specified" do
      let(:options) { { secure: true } }

      it "uses that security parameter" do
        request.should be_secure
      end
    end
    
    context "when not provided with an HTTP version" do
      it "uses HTTP/1.1" do
        request.http_version.should == HTTPVersion::ONE_POINT_ONE
      end
    end    

    context "when provided with an HTTP version" do
      let(:options) { { http_version: "HTTP/1.0" } }
      let(:http_version) { double(:http_version) }

      before do
        HTTPVersion.stub(:interpret).with("HTTP/1.0") { http_version }
      end

      it "uses that HTTP version" do
        request.http_version.should == http_version
      end
    end

    it "can recreate the URL of the request" do
      recreator = double(:recreator, recreate: "http://google.com")
      request.url(recreator).should == "http://google.com"
    end
  end
end
