require 'spec_helper'

describe Webbed::GenericMessage do
  subject { message }
  let(:message) do
    klass = Class.new
    klass.instance_eval { include Webbed::GenericMessage }
    klass.new
  end
  
  context "when created" do
    its(:headers) { should be_nil }
    its(:entity_body) { should be_nil }
  end
  
  describe "#http_version" do
    it "should change #http_version" do
      lambda {
        message.http_version = 'HTTP/1.0'
      }.should change(message, :http_version).from(nil).to(1.0)
    end
  end
  
  describe "#headers=" do
    it "should change #headers" do
      lambda {
        message.headers = {'Host' => 'foo.bar'}
      }.should change(message, :headers).from(nil).to({'Host' => 'foo.bar'})
    end
  end
  
  describe "#entity_body=" do
    it "should change #entity_body" do
      lambda {
        message.entity_body = 'foo'
      }.should change(message, :entity_body).from(nil).to('foo')
    end
  end
  
  describe "#to_s" do
    before do
      message.should_receive(:start_line).and_return("Start Line\r\n")
      message.should_receive(:headers).and_return("Headers\r\n")
      message.should_receive(:entity_body).and_return('Entity Body')
    end
    
    it "should concatenate the start line, headers, and entity body in that order" do
      message.to_s.should == "Start Line\r\nHeaders\r\n\r\nEntity Body"
    end
  end
end