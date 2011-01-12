require 'spec_helper'

describe Webbed::Helpers::SchemeHelper do
  context "when the scheme is https" do
    before do
      @request = Webbed::Request.new ['GET', '*', {}, ''], :scheme => 'https'
    end
    
    it "should be secure" do
      @request.should be_secure
    end
  end
  
  context "when the scheme is http" do
    before do
      @request = Webbed::Request.new ['GET', '*', {}, ''], :scheme => 'http'
    end
    
    it "should be insecure" do
      @request.should_not be_secure
    end
  end
end