require 'spec_helper'

describe Webbed::Request do
  let(:post) do
    Webbed::Request.new([
      'POST',
      'http://google.com',
      'HTTP/1.0',
      {
        'Content-Type' => 'text/plain',
        'Content-Length' => '10',
        'Host' => 'google.com'
      },
      'Test 1 2 3'
    ])
  end
  
  context "when created" do
    it "should set #method" do
      post.method.should == Webbed::Method::POST
    end
    
    it "should set #request_uri" do
      post.request_uri.to_s.should == 'http://google.com'
    end
    
    it "should set #http_version" do
      post.http_version.should == Webbed::HTTPVersion::ONE_POINT_OH
    end
    
    it "should set #headers" do
      post.headers['Content-Type'].should == 'text/plain'
      post.headers['Content-Length'].should == '10'
      post.headers['Host'].should == 'google.com'
    end
    
    it "should set #entity_body" do
      post.entity_body.should == 'Test 1 2 3'
    end
  end
  
  describe "#method=" do
    it "should change #method" do
      lambda {
        post.method = 'GET'
      }.should change(post, :method).from(Webbed::Method::POST).to(Webbed::Method::GET)
    end
  end
  
  describe "#method" do
    context "when called with arguments" do
      it "should call super" do
        post.method(:__send__).should be_an_instance_of(Method)
      end
    end
    
    context "when called without arguments" do
      it "should return the method" do
        post.method.should == Webbed::Method::POST
      end
    end
  end
end