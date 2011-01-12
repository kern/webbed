require 'spec_helper'

describe Webbed::Helpers::RackRequestHelper do
  describe ".from_rack" do
    before do
      @rack_env = {
        'REQUEST_METHOD'  => 'GET',
        'SCRIPT_NAME'     => '',
        'PATH_INFO'       => '/test',
        'QUERY_STRING'    => 'foo=bar',
        'HTTP_HOST'       => 'google.com',
        'HTTP_ACCEPT'     => '*/*',
        'CONTENT_TYPE'    => 'text/plain',
        'CONTENT_LENGTH'  => '0',
        'HTTP_VERSION'    => 'HTTP/1.0',
        'rack.url_scheme' => 'https',
        'rack.input'      => StringIO.new('Foobar')
      }
      
      @request = Webbed::Request.from_rack @rack_env
    end
    
    it "should set #method" do
      @request.method.should == Webbed::Method::GET
    end
    
    it "should set #request_uri" do
      @request.request_uri.should == Addressable::URI.parse('/test?foo=bar')
    end
    
    it "should set #headers" do
      @request.headers['Host'].should == 'google.com'
      @request.headers['Accept'].should == '*/*'
      @request.headers['Content-Type'].should == 'text/plain'
      @request.headers['Content-Length'].should == '0'
    end
    
    it "should set #scheme" do
      @request.scheme.should == 'https'
    end
    
    it "should set #entity_body" do
      @request.entity_body.gets.should == 'Foobar'
    end
    
    it "should set #rack_env to the original Rack environment" do
      @request.rack_env.should equal(@rack_env)
    end
    
    context "when an HTTP-Version is provided" do
      it "should set #http_version" do
        @request.http_version.should == Webbed::HTTPVersion::ONE_POINT_OH
      end
    end
    
    context "when an HTTP-Verison is not provided" do
      before do
        @request = Webbed::Request.from_rack({
          'REQUEST_METHOD' => 'GET',
          'SCRIPT_NAME'    => '',
          'PATH_INFO'      => '/test',
          'QUERY_STRING'   => 'foo=bar',
          'HTTP_HOST'      => 'google.com'
        })
      end
      
      it "should set #http_version to HTTP/1.1" do
        @request.http_version.should == Webbed::HTTPVersion::ONE_POINT_ONE
      end
    end
  end
end
