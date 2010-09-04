require 'spec_helper'

describe Webbed::GenericMessage do
  before do
    @klass = Class.new
    @klass.instance_eval { include Webbed::GenericMessage }
  end
  
  subject { @klass.new }
  
  context 'when created' do
    its(:headers) { should be_nil }
    its(:entity_body) { should be_nil }
  end
  
  context 'when the HTTP Version is modified' do
    it 'should change the HTTP Version' do
      lambda {
        subject.http_version = 'HTTP/1.0'
      }.should change(subject, :http_version).from(nil).to(1.0)
    end
  end
  
  context 'when the headers are modified' do
    it 'should change the headers' do
      lambda {
        subject.headers = {'Host' => 'foo.bar'}
      }.should change(subject, :headers).from(nil).to({'Host' => 'foo.bar'})
    end
  end
  
  context 'when the entity body is modified' do
    it 'should change the entity body' do
      lambda {
        subject.entity_body = 'foo'
      }.should change(subject, :entity_body).from(nil).to('foo')
    end
  end
  
  describe '#to_s' do
    before do
      subject.stub_methods({
        :start_line => "Start Line\r\n",
        :headers => "Headers\r\n",
        :entity_body => 'Entity Body'
      })
      
      @string = subject.to_s
    end
    
    it { should have_received(:start_line) }
    it { should have_received(:headers) }
    it { should have_received(:entity_body) }
    
    it 'should concatenate the start line, headers, and entity body in that order' do
      @string.should == "Start Line\r\nHeaders\r\n\r\nEntity Body"
    end
  end
end