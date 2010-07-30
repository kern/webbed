require 'spec_helper'

describe Webbed::GenericMessage do
  subject { Webbed::GenericMessage.new }
  
  its(:start_line) { should == "Invalid Start Line\r\n" }
  its(:headers) { should be_an_instance_of(Webbed::Headers) }
  
  context 'when created' do
    its(:http_version) { should == Webbed::HTTPVersion::ONE_POINT_ONE }
    its(:headers) { should be_empty }
    its(:entity_body) { should be_empty }
  end
  
  context 'when the HTTP Version is modified' do
    it 'should change the HTTP Version' do
      lambda {
        subject.http_version = 'HTTP/1.0'
      }.should change(subject, :http_version).from(1.1).to(1.0)
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
      subject.stubs(:start_line).returns("Start Line\r\n")
      subject.stubs(:headers).returns("Headers\r\n")
      subject.stubs(:entity_body).returns('Entity Body')
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