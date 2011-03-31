require 'spec_helper'

describe Webbed::Helpers::RackResponseHelper do
  before do
    @response = Webbed::Response.new [200, {}, '']
  end
  
  describe "#to_rack" do
    it "should convert the response to a Rack response array" do
      @response.to_rack.should == [200, {}, '']
    end
  end
  
  describe "#to_a" do
    it "should be a Rack response array with the reason phrase as well" do
      @response.to_a.should == ['200 OK', {}, '']
    end
  end
end