require "spec_helper"
require "addressable/uri"
require "webbed/request"
require "webbed/http_version"

module Webbed
  describe Request do
    let(:method) { double(:method) }
    let(:request_uri) { double(:request_uri) }
    let(:headers) { double(:headers) }
    let(:options) { {} }
    subject { Request.new("GET", "/", {}, options) }

    before do
      Method.stub(:look_up).with("GET") { method }
      Addressable::URI.stub(:parse).with("/") { request_uri }
      Headers.stub(:new).with({}) { headers }
    end

    it "converts the method to an instance of Webbed::Method" do
      subject.method.should == method
    end

    it "converts the request URI to an instance of Addressable::URI" do
      subject.request_uri.should == request_uri
    end

    it "converts the headers to an instance of Webbed::Headers" do
      subject.headers.should == headers
    end

    context "when not provided with an entity body" do
      it "has no entity body" do
        subject.entity_body.should == nil
      end
    end

    context "when provided with an entity body" do
      let(:options) { { entity_body: ["test"] } }

      it "has an entity body" do
        subject.entity_body.should == ["test"]
      end
    end

    context "when the request's security has not been specified" do
      it "is unsafe" do
        subject.should_not be_secure
      end
    end

    context "when the request's security has been specified" do
      let(:options) { { secure: true } }

      it "uses that security parameter" do
        subject.should be_secure
      end
    end
    
    context "when not provided with an HTTP version" do
      it "uses HTTP/1.1" do
        subject.http_version.should == HTTPVersion::ONE_POINT_ONE
      end
    end    

    context "when provided with an HTTP version" do
      let(:options) { { http_version: "HTTP/1.0" } }
      let(:http_version) { double(:http_version) }

      before do
        HTTPVersion.stub(:parse).with("HTTP/1.0") { http_version }
      end

      it "uses that HTTP version" do
        subject.http_version.should == http_version
      end
    end

    it "can recreate the URL of the request" do
      recreator = double(:recreator, recreate: "http://google.com")
      URLRecreator.stub(:new).with(subject) { recreator }
      subject.url.should == "http://google.com"
    end
  end
end
