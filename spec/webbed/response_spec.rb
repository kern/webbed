require 'spec_helper'

describe Webbed::Response do
  subject do
    Webbed::Response.new([
      'HTTP/1.0',
      '200 OK',
      {
        'Content-Type' => 'text/plain',
        'Content-Length' => '10'
      },
      'Test 1 2 3'
    ])
  end
  
  context 'when created' do
    context 'with a Reason-Phrase' do
      it 'should store the Reason-Phrase' do
        subject.reason_phrase.to_s.should == 'OK'
      end
      
      it 'should store the Status-Code' do
        subject.status_code.should == Webbed::StatusCode.new(200)
      end
    end
    
    context 'without a Reason-Phrase' do
      subject do
        Webbed::Response.new([
          'HTTP/1.0',
          404,
          {
            'Content-Type' => 'text/plain',
            'Content-Length' => '10'
          },
          'Test 1 2 3'
        ])
      end
      
      it 'should store the default Reason-Phrase' do
        subject.reason_phrase.to_s.should == 'Not Found'
      end
      
      it 'should store the Status-Code' do
        subject.status_code.should == Webbed::StatusCode.new(404)
      end
    end
    
    it 'should store the HTTP Version' do
      subject.http_version.should == Webbed::HTTPVersion::ONE_POINT_OH
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
      it 'should have the same reason phrase' do
        lambda {
          subject.status_code = 500
        }.should_not change(subject, :reason_phrase)
      end
    end
    
    context 'when no override reason phrase is set' do
      before do
        subject.reason_phrase = nil
      end
      
      it 'should also change the default reason phrase' do
        lambda {
          subject.status_code = 100
        }.should change(subject, :reason_phrase).from('OK').to('Continue')
      end
    end
  end
end