require 'spec_helper'

describe Webbed::Helpers::RequestURIHelper do
  before do
    @request = Webbed::Request.new ['GET', '/foo', 'HTTP/1.1', {'Host' => 'example.com'}, '']
  end
  
  describe "#request_url" do
    it "should equal #request_uri" do
      @request.request_url.should == @request.request_uri
    end
  end
  
  describe "#host" do
    context "when there is no Host header" do
      before do
        @request.headers = {}
      end
      
      it "should be nil" do
        @request.host.should be_nil
      end
    end
    
    context "when there is a Host header" do
      it "should return the value of the header" do
        @request.host.should == 'example.com'
      end
    end
  end
  
  describe "#uri" do
    context "when #host is not set" do
      before do
        @request.headers = {}
      end
      
      it "should return #request_uri" do
        @request.uri.should == @request.request_uri
      end
    end
    
    context "when #host is set" do
      context "when #request_uri already has a host" do
        before do
          @request.request_uri = 'http://example2.com/foo'
        end
        
        it "should return #request_uri" do
          @request.uri.should == @request.request_uri
        end
      end
      
      context "when #request_uri does not have a host" do
        it "should return an Addressable::URI with a #host that is the request's #host" do
          @request.uri.should == Addressable::URI.parse('http://example.com/foo')
        end
      end
    end
  end
end