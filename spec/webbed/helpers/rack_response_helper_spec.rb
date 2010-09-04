require 'spec_helper'

describe Webbed::Helpers::RackResponseHelper do
  subject { Webbed::Response.new ['HTTP/1.1', 200, {}, ''] }
  
  describe '#to_rack' do
    it 'should convert the response to a Rack response array' do
      subject.to_rack.should == [200, {}, '']
    end
  end
  
  describe '#to_a' do
    it 'should be the same method as #to_rack' do
      subject.method(:to_a).should == subject.method(:to_rack)
    end
  end
end