require 'spec_helper'

describe Webbed::Request do
  it 'should include Webbed::GenericMessage' do
    Webbed::Request.ancestors.should include(Webbed::GenericMessage)
  end
  
  context 'when created without arguments' do
    before do
      @request = Webbed::Request.new
    end
    
    subject { @request }
    
    its(:method) { should == Webbed::Method::GET }
    its(:request_uri) { subject.to_s.should == '*' }
    its(:http_version) { should == Webbed::HTTPVersion::ONE_POINT_ONE }
    its(:headers) { should be_empty }
    its(:request_line) { should == "GET * HTTP/1.1\r\n" }
    its(:start_line) { should == @request.request_line }
  end
  
  context 'when created with a request hash' do
    subject do
      Webbed::Request.new({
        :method => 'POST',
        :request_uri => 'http://google.com',
        :http_version => 'HTTP/1.0',
        :headers => {
          'Content-Type' => 'text/plain',
          'Content-Length' => '0',
          'Host' => 'google.com'
        },
        :entity_body => 'Test 1 2 3'
      })
    end
    
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
      subject.headers['Content-Length'].should == '0'
      subject.headers['Host'].should == 'google.com'
    end
    
    it 'should store the entity body' do
      subject.entity_body.should == 'Test 1 2 3'
    end
  end
  
  context 'when the method is set' do
    subject { Webbed::Request.new }
    
    it 'should change the method' do
      lambda {
        subject.method = 'POST'
      }.should change(subject, :method).from(Webbed::Method::GET).to(Webbed::Method::POST)
    end
  end
  
  describe '#method with arguments' do
    subject { Webbed::Request.new.method(:__send__) }
    it { should be_an_instance_of(Method) }
  end
end