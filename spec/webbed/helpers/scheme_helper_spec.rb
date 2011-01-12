require 'spec_helper'

describe Webbed::Helpers::SchemeHelper do
  context "when the #scheme is http" do
    before do
      @request = Webbed::Request.new ['GET', '*', {}, ''], :scheme => 'http'
    end
    
    it "should be insecure" do
      @request.should_not be_secure
    end
    
    it "should have a #default_port of 80" do
      @request.default_port.should == 80
    end
  end
  
  context "when the #scheme is https" do
    before do
      @request = Webbed::Request.new ['GET', '*', {}, ''], :scheme => 'https'
    end
    
    it "should be secure" do
      @request.should be_secure
    end
    
    it "should have a #default_port of 443" do
      @request.default_port.should == 443
    end
  end
  
  context "when the #scheme is neither http nor https" do
    before do
      @request = Webbed::Request.new ['GET', '*', {}, ''], :scheme => 'foo'
    end
    
    it "should be insecure" do
      @request.should_not be_secure
    end
    
    it "should have a #default_port of nil" do
      @request.default_port.should be_nil
    end
  end
end