require 'spec_helper'

describe Webbed::Method do
  describe '#initialize' do
    subject { Webbed::Method.new('FAKE') }
    
    it 'should be created with a method name' do
      subject.name.should == 'FAKE'
    end
    
    it 'should be unsafe by default' do
      subject.should_not be_safe
    end
    
    it 'should have a request enitity by default' do
      subject.has_request_entity?.should be_true
    end
    
    it 'should have a response enitity by default' do
      subject.has_response_entity?.should be_true
    end
  end
  
  describe 'safe method' do
    subject { Webbed::Method.new('GET', :safe) }
    it { should be_safe }
    it { should be_idempotent }
  end
  
  describe 'idempotent method' do
    subject { Webbed::Method.new('PUT', :idempotent) }
    it { should_not be_safe }
    it { should be_idempotent }
  end
  
  describe 'unsafe method' do
    subject { Webbed::Method.new('POST', :unsafe) }
    it { should_not be_safe }
    it { should_not be_idempotent }
  end
  
  describe 'headers only method' do
    subject { Webbed::Method.new('HEAD', :safe, :no_entities) }
    specify { subject.has_request_entity?.should be_false }
    specify { subject.has_response_entity?.should be_false }
  end
  
  describe 'method with only response entity' do
    subject { Webbed::Method.new('GET', :safe, :only_response_entity) }
    specify { subject.has_request_entity?.should be_false }
    specify { subject.has_response_entity?.should be_true }
  end
  
  describe 'method with both request and response entities' do
    subject { Webbed::Method.new('POST', :unsafe, :both_entities) }
    specify { subject.has_request_entity?.should be_true }
    specify { subject.has_response_entity?.should be_true }
  end
  
  describe '#to_s' do
    it 'should return the name of the method' do
      Webbed::Method.post.to_s.should == 'POST'
    end
  end
  
  describe '#==' do
    it 'should equal the method name' do
      Webbed::Method.post.should == 'POST'
    end
    
    it 'should not be equal to anything else' do
      Webbed::Method.post.should_not == 'PUT'
    end
    
    it 'should be equal to a method of the same name' do
      Webbed::Method.post.should == Webbed::Method.post
    end
    
    it 'should not be equal to a method of a different name' do
      Webbed::Method.post.should_not == Webbed::Method.put
    end
  end
  
  describe '#self.options' do
    subject { Webbed::Method.options }
    specify { subject.name.should == 'OPTIONS' }
    it { should be_safe }
    it { should be_idempotent }
    specify { subject.has_request_entity?.should be_false }
    specify { subject.has_response_entity?.should be_true }
  end
  
  describe '#self.get' do
    subject { Webbed::Method.get }
    specify { subject.name.should == 'GET' }
    it { should be_safe }
    it { should be_idempotent }
    specify { subject.has_request_entity?.should be_false }
    specify { subject.has_response_entity?.should be_true }
  end
  
  describe '#self.head' do
    subject { Webbed::Method.head }
    specify { subject.name.should == 'HEAD' }
    it { should be_safe }
    it { should be_idempotent }
    specify { subject.has_request_entity?.should be_false }
    specify { subject.has_response_entity?.should be_false }
  end
  
  describe '#self.post' do
    subject { Webbed::Method.post }
    specify { subject.name.should == 'POST' }
    it { should_not be_safe }
    it { should_not be_idempotent }
    specify { subject.has_request_entity?.should be_true }
    specify { subject.has_response_entity?.should be_true }
  end
  
  describe '#self.put' do
    subject { Webbed::Method.put }
    specify { subject.name.should == 'PUT' }
    it { should_not be_safe }
    it { should be_idempotent }
    specify { subject.has_request_entity?.should be_true }
    specify { subject.has_response_entity?.should be_true }
  end
  
  describe '#self.delete' do
    subject { Webbed::Method.delete }
    specify { subject.name.should == 'DELETE' }
    it { should_not be_safe }
    it { should be_idempotent }
    specify { subject.has_request_entity?.should be_false }
    specify { subject.has_response_entity?.should be_true }
  end
  
  describe '#self.trace' do
    subject { Webbed::Method.trace }
    specify { subject.name.should == 'TRACE' }
    it { should be_safe }
    it { should be_idempotent }
    specify { subject.has_request_entity?.should be_false }
    specify { subject.has_response_entity?.should be_true }
  end
  
  describe '#self.connect' do
    subject { Webbed::Method.connect }
    specify { subject.name.should == 'CONNECT' }
    it { should_not be_safe }
    it { should_not be_idempotent }
    specify { subject.has_request_entity?.should be_true }
    specify { subject.has_response_entity?.should be_true }
  end
  
  describe '#self.patch' do
    subject { Webbed::Method.patch }
    specify { subject.name.should == 'PATCH' }
    it { should_not be_safe }
    it { should_not be_idempotent }
    specify { subject.has_request_entity?.should be_true }
    specify { subject.has_response_entity?.should be_true }
  end
end