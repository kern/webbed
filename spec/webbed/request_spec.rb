require 'spec_helper'

describe Webbed::Request do
  before do
    @request = Webbed::Request.new([
      'POST',
      'http://google.com',
      {
        'Content-Type' => 'text/plain',
        'Content-Length' => '10',
        'Host' => 'google.com'
      },
      'Test 1 2 3'
    ])
    
    @one_point_oh = Webbed::Request.new([
      'POST',
      'http://google.com',
      {
        'Content-Type' => 'text/plain',
        'Content-Length' => '10',
        'Host' => 'google.com'
      },
      'Test 1 2 3'
    ], :http_version => 1.0)
  end
  
  context "when created" do
    it "should set #method" do
      @request.method.should == Webbed::Method::POST
    end
    
    it "should set #request_uri" do
      @request.request_uri.to_s.should == 'http://google.com'
    end
    
    it "should set #headers" do
      @request.headers['Content-Type'].should == 'text/plain'
      @request.headers['Content-Length'].should == '10'
      @request.headers['Host'].should == 'google.com'
    end
    
    it "should set #entity_body" do
      @request.entity_body.should == 'Test 1 2 3'
    end
  end
  
  context "when created without an #http_version" do
    it "should set #http_version to HTTP/1.1" do
      @request.http_version.should == Webbed::HTTPVersion::ONE_POINT_ONE
    end
  end
  
  context "when created with an #http_version" do
    it "should set #http_version" do
      @one_point_oh.http_version.should == Webbed::HTTPVersion::ONE_POINT_OH
    end
  end
  
  describe "#method=" do
    it "should change #method" do
      lambda {
        @request.method = 'GET'
      }.should change(@request, :method).from(Webbed::Method::POST).to(Webbed::Method::GET)
    end
  end
  
  describe "#method" do
    context "when called with arguments" do
      it "should call super" do
        @request.method(:__send__).should be_an_instance_of(Method)
      end
    end
    
    context "when called without arguments" do
      it "should return the method" do
        @request.method.should == Webbed::Method::POST
      end
    end
  end
end