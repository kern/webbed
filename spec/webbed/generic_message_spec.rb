require 'spec_helper'

describe Webbed::GenericMessage do
  before do
    @klass = Class.new
    @klass.instance_eval { include Webbed::GenericMessage }
  end
  
  subject { @klass.new }
  
  context 'when created' do
    its(:headers) { should be_empty }
    its(:entity_body) { should be_empty }
  end
  
  context 'when the HTTP Version is modified' do
    it 'should change the HTTP Version' do
      lambda {
        subject.http_version = 'HTTP/1.0'
      }.should change(subject, :http_version).from(nil).to(1.0)
    end
  end
  
  context 'when the entity body is modified' do
    it 'should change the entity body' do
      lambda {
        subject.entity_body = 'foo'
      }.should change(subject, :entity_body).from('').to('foo')
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