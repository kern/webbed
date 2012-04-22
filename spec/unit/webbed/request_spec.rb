require "spec_helper"
require "addressable/uri"
require "webbed/request"
require "webbed/http_version"

describe Webbed::Request do
  let(:headers) { { "Host" => "www.google.com" } }
  let(:request) { Webbed::Request.new("GET", "/", headers) }
  subject { request }
  
  describe "#initialize" do
    it "sets the method" do
      subject.method.should == Webbed::Method::GET
    end

    it "sets the request URI" do
      subject.request_uri.should == Addressable::URI.parse("/")
    end

    it "sets the headers" do
      subject.headers.should == headers
    end

    context "when not provided with an entity body" do
      it "has no entity body" do
        subject.entity_body.should be_nil
      end
    end    

    context "when provided with an entity body" do
      let(:request) { Webbed::Request.new("GET", "/", headers, entity_body: ["foobar"]) }

      it "sets the entity body" do
        subject.entity_body.should == ["foobar"]
      end
    end

    context "when not provided with an HTTP version" do
      it "uses HTTP/1.1" do
        subject.http_version.should == Webbed::HTTPVersion::ONE_POINT_ONE
      end
    end    

    context "when provided with an HTTP version" do
      let(:request) { Webbed::Request.new("GET", "/", headers, http_version: "HTTP/1.0") }

      it "sets the HTTP version" do
        subject.http_version.should == Webbed::HTTPVersion::ONE_POINT_OH
      end
    end

    context "when the request security is not specified" do
      it "is insecure" do
        subject.should_not be_secure
      end
    end    

    context "when the request security is specified" do
      let(:request) { Webbed::Request.new("GET", "/", headers, secure: true) }

      it "sets the security" do
        subject.should be_secure
      end
    end
  end

  describe "#method" do
    subject { request.method }

    it "is an instance of Webbed::Method" do
      subject.should be_a(Webbed::Method)
    end
  end

  describe "#request_uri" do
    subject { request.request_uri }

    it "is an instance of Addressable::URI" do
      subject.should be_an(Addressable::URI)
    end
  end

  describe "#headers" do
    subject { request.headers }

    it "is an instance of Webbed::Headers" do
      subject.should be_a(Webbed::Headers)
    end
  end

  describe "#http_version" do
    subject { request.http_version }

    it "is an instance of Webbed::HTTPVersion" do
      subject.should be_a(Webbed::HTTPVersion)
    end
  end

  describe "#url" do
    subject { request.url }

    context "when the request URI has a host" do
      let(:request) { Webbed::Request.new("GET", "http://www.google.com", {}) }
      
      it "returns the request URI" do
        subject.should == request.request_uri
      end
    end

    context "when the request URI does not have a host" do
      context "when the Host header is present" do
        context "when the request is insecure" do
          let(:request) { Webbed::Request.new("GET", "/search", headers) }
          
          it "returns the the HTTP scheme Host header as the host for the request URI" do
            subject.should == Addressable::URI.parse("http://www.google.com/search")
          end
        end

        context "when the request is secure" do
          let(:request) { Webbed::Request.new("GET", "/search", headers, secure: true) }
          
          it "returns the the HTTPS scheme Host header as the host for the request URI" do
            subject.should == Addressable::URI.parse("https://www.google.com/search")
          end
        end
      end

      context "when the Host header is not present" do
        let(:request) { Webbed::Request.new("GET", "/search", {}) }
        
        it "returns the request URI" do
          subject.should == request.request_uri
        end
      end
    end
  end
end
