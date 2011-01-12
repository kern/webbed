require 'spec_helper'

describe Webbed::Helpers::RackRequestHelper do
  describe ".from_rack" do
    before do
      @request = Webbed::Request.from_rack({
        'REQUEST_METHOD' => 'GET'
      })
    
    it "should set #method" do
      @request.method.should == Webbed::Method::GET
    end
  end
end