require 'spec_helper'

describe Webbed::Response do
  context 'when created without arguments' do
    before do
      @response = Webbed::Response.new
    end
    
    subject { @response }
    
    its(:http_version) { should == Webbed::HTTPVersion::ONE_POINT_ONE }
    its(:status_code) { should == 200 }
    its(:reason_phrase) { should == 'OK' }
    its(:default_reason_phrase) { should == 'OK' }
    its(:headers) { should be_empty }
    its(:status_line) { should == "HTTP/1.1 200 OK\r\n" }
    its(:start_line) { should == @response.status_line }
  end
  
  context 'when created with a response hash' do
    subject do
      Webbed::Response.new({
        :http_version => 'HTTP/1.0',
        :status_code => 404,
        :reason_phrase => 'File Not Found',
        :headers => {
          'Content-Type' => 'text/plain',
          'Content-Length' => '10'
        },
        :entity_body => 'Test 1 2 3'
      })
    end
    
    it 'should store the HTTP Version' do
      subject.http_version.should == Webbed::HTTPVersion::ONE_POINT_OH
    end
    
    it 'should store the status code' do
      subject.status_code.should == Webbed::StatusCode.new(404)
    end
    
    it 'should store the Reason Phrase' do
      subject.reason_phrase.to_s.should == 'File Not Found'
    end
    
    it 'should store the headers' do
      subject.headers['Content-Type'].should == 'text/plain'
      subject.headers['Content-Length'].should == '10'
    end
    
    it 'should store the entity body' do
      subject.entity_body.should == 'Test 1 2 3'
    end
  end
  
  context 'when the status code is set' do
    subject { Webbed::Response.new }
    
    it 'should change the status code' do
      lambda {
        subject.status_code = 500
      }.should change(subject, :status_code).from(200).to(500)
    end
    
    it 'should change the default reason phrase' do
      lambda {
        subject.status_code = 100
      }.should change(subject, :default_reason_phrase).from('OK').to('Continue')
    end
    
    context 'when an override reason phrase is set' do
      subject { Webbed::Response.new :reason_phrase => 'foo' }
      
      it 'should have the same reason phrase' do
        lambda {
          subject.status_code = 500
        }.should_not change(subject, :reason_phrase)
      end
    end
    
    context 'when no override reason phrase is set' do
      subject { Webbed::Response.new }
      
      it 'should also change the default reason phrase' do
        lambda {
          subject.status_code = 100
        }.should change(subject, :reason_phrase).from('OK').to('Continue')
      end
    end
  end
end