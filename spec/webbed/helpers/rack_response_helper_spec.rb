require 'spec_helper'

describe Webbed::Helpers::RackResponseHelper do
  subject do
    Webbed::Response.new({
      :http_version => 'HTTP/1.1',
      :status_code => 200,
      :headers => {
        'Content-Type' => 'text/plain'
      },
      :entity_body => ''
    })
  end
  
  describe '#to_rack' do
    it 'should convert the response to a Rack response array' do
      subject.to_rack.should == [200, {'Content-Type' => 'text/plain'}, '']
    end
  end
  
  describe '#to_a' do
    it 'should be the same method as #to_rack' do
      subject.method(:to_a).should == subject.method(:to_rack)
    end
  end
end