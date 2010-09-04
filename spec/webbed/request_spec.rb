require 'spec_helper'

describe Webbed::Request do
  subject do
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
  
  context 'when created with a full request array' do
    it 'should store the method' do
      subject.method.should == Webbed::Method::POST
    end
    
    it 'should store the Request URI' do
      subject.request_uri.to_s.should == 'http://google.com'
    end
    
    it 'should store the HTTP Version' do
      subject.http_version.should == Webbed::HTTPVersion::ONE_POINT_OH
    end
    
    it 'should store the headers' do
      subject.headers['Content-Type'].should == 'text/plain'
      subject.headers['Content-Length'].should == '10'
      subject.headers['Host'].should == 'google.com'
    end
    
    it 'should store the entity body' do
      subject.entity_body.should == 'Test 1 2 3'
    end
  end
  
  context 'when the method is set' do
    it 'should change the method' do
      lambda {
        subject.method = 'GET'
      }.should change(subject, :method).from(Webbed::Method::POST).to(Webbed::Method::GET)
    end
  end
  
  describe '#method with arguments' do
    it 'should call super' do
      subject.method(:__send__).should be_an_instance_of(Method)
    end
  end
end