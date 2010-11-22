require 'spec_helper'

describe Webbed::Helpers::RequestUriHelper do
  let(:request) { Webbed::Request.new ['GET', '/foo', 'HTTP/1.1', {'Host' => 'example.com'}, ''] }
  let(:request_without_host) { Webbed::Request.new ['GET', '/foo', 'HTTP/1.1', {}, ''] }
  let(:proxied_request) { Webbed::Request.new ['GET', 'http://example2.com/foo', 'HTTP/1.1', {'Host' => 'example.com'}, ''] }
  
  describe "#request_url" do
    it "should equal #request_uri" do
      request.request_url.should == request.request_uri
    end
  end
  
  describe "#host" do
    context "when there is no Host header" do
      it "should be nil" do
        request_without_host.host.should be_nil
      end
    end
    
    context "when there is a Host header" do
      it "should return the value of the header" do
        request.host.should == 'example.com'
      end
    end
  end
  
  describe "#uri" do
    context "when #host is not set" do
      it "should return #request_uri" do
        request_without_host.uri.should == request_without_host.request_uri
      end
    end
    
    context "when #host is set" do
      context "when #request_uri already has a host" do
        it "should return #request_uri" do
          proxied_request.uri.should == proxied_request.request_uri
        end
      end
      
      context "when #request_uri does not have a host" do
        it "should return an Addressable::URI with a #host that is the request's #host" do
          request.uri.should == Addressable::URI.parse('http://example.com/foo')
        end
      end
    end
  end
end