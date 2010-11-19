require 'spec_helper'

describe Webbed::Response do
  let(:ok) do
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
  
  let(:not_found) do
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
  
  context "when created with a Reason Phrase" do
    it "should set #reason_phrase" do
      ok.reason_phrase.to_s.should == 'OK'
    end
    
    it "should set #status_code" do
      ok.status_code.should == 200
    end
  end
  
  context "when created without a Reason Phrase" do
    it "should set the #reason_phrase to the default" do
      not_found.reason_phrase.to_s.should == 'Not Found'
    end
    
    it "should set #status_code" do
      not_found.status_code.should == 404
    end
  end
  
  context "when created" do
    it "should set #http_version" do
      ok.http_version.should == Webbed::HTTPVersion::ONE_POINT_OH
    end
    
    it "should set #headers" do
      ok.headers['Content-Type'].should == 'text/plain'
      ok.headers['Content-Length'].should == '10'
    end
    
    it "should set #entity_body" do
      ok.entity_body.should == 'Test 1 2 3'
    end
  end
  
  describe "#status_code=" do
    it "should change #status_code" do
      lambda {
        ok.status_code = 500
      }.should change(ok, :status_code).from(200).to(500)
    end
    
    it "should change #default_reason_phrase" do
      lambda {
        ok.status_code = 100
      }.should change(ok, :default_reason_phrase).from('OK').to('Continue')
    end
    
    context "when #reason_phrase is set" do
      it "should have the same #reason_phrase" do
        lambda {
          ok.status_code = 500
        }.should_not change(ok, :reason_phrase)
      end
    end
    
    context "when no #reason_phrase is set" do
      it "should change #reason_phrase" do
        lambda {
          not_found.status_code = 100
        }.should change(not_found, :reason_phrase).from('Not Found').to('Continue')
      end
    end
  end
end