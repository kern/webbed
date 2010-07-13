require 'spec_helper'

describe Webbed::Method do
  context 'when created without options' do
    subject { Webbed::Method.new('FAKE') }
    
    it 'should store the method name' do
      subject.name.should == 'FAKE'
    end
    
    it { should_not be_safe }
    it { should_not be_idempotent }
    it { should have_entity(:request) }
    it { should have_entity(:response) }
  end
  
  context 'when created as a safe method' do
    subject { Webbed::Method.new('FAKE', :safe => true) }
    
    it { should be_safe }
    it { should be_idempotent }
  end
  
  context 'when created as an idempotent method' do
    subject { Webbed::Method.new('FAKE', :idempotent => true) }
    
    it { should_not be_safe }
    it { should be_idempotent }
  end
  
  context 'when created as an unsafe method' do
    subject { Webbed::Method.new('FAKE', :safe => false) }
    
    it { should_not be_safe }
    it { should_not be_idempotent }
  end
  
  context 'when created as a headers only method' do
    subject { Webbed::Method.new('FAKE', :entities => []) }
    
    it { should_not have_entity(:request) }
    it { should_not have_entity(:response) }
  end
  
  context 'when created as a response entity only method' do
    subject { Webbed::Method.new('FAKE', :entities => [:response]) }
    
    it { should_not have_entity(:request) }
    it { should have_entity(:response) }
  end
  
  context 'when created as a two entity method' do
    subject { Webbed::Method.new('FAKE', :entities => [:request, :response]) }
    
    it { should have_entity(:request) }
    it { should have_entity(:response) }
  end
  
  context 'when created with a known method name' do
    subject { Webbed::Method.new('GET') }
    
    it 'should return the exact same method object each time' do
      should equal(Webbed::Method::GET)
    end
  end
  
  describe '#==' do
    subject { Webbed::Method::POST }
    
    it 'should equal the method name' do
      should == 'POST'
    end
    
    it 'should equal an identical method' do
      should == Webbed::Method::POST
    end
  end
  
  describe '#to_s' do
    it 'should return the name of the method' do
      Webbed::Method::POST.to_s.should == 'POST'
    end
  end
end

describe Webbed::Method::OPTIONS do
  subject { Webbed::Method::OPTIONS }
  
  its(:name) { should == 'OPTIONS' }
  it { should be_safe }
  it { should be_idempotent }
  it { should_not have_entity(:request) }
  it { should have_entity(:response) }
end

describe Webbed::Method::GET do
  subject { @method = Webbed::Method::GET }
  
  its(:name) { should == 'GET' }
  it { should be_safe }
  it { should be_idempotent }
  it { should_not have_entity(:request) }
  it { should have_entity(:response) }
end

describe Webbed::Method::HEAD do
  subject { Webbed::Method::HEAD }
  
  its(:name) { should == 'HEAD' }
  it { should be_safe }
  it { should be_idempotent }
  it { should_not have_entity(:request) }
  it { should_not have_entity(:response) }
end

describe Webbed::Method::POST do
  subject { Webbed::Method::POST }
  
  its(:name) { should == 'POST' }
  it { should_not be_safe }
  it { should_not be_idempotent }
  it { should have_entity(:request) }
  it { should have_entity(:response) }
end

describe Webbed::Method::PUT do
  subject { Webbed::Method::PUT }
  
  its(:name) { should == 'PUT' }
  it { should_not be_safe }
  it { should be_idempotent }
  it { should have_entity(:request) }
  it { should have_entity(:response) }
end

describe Webbed::Method::DELETE do
  subject { Webbed::Method::DELETE }
  
  its(:name) { should == 'DELETE' }
  it { should_not be_safe }
  it { should be_idempotent }
  it { should_not have_entity(:request) }
  it { should have_entity(:response) }
end

describe Webbed::Method::TRACE do
  subject { Webbed::Method::TRACE }
  
  its(:name) { should == 'TRACE' }
  it { should be_safe }
  it { should be_idempotent }
  it { should_not have_entity(:request) }
  it { should have_entity(:response) }
end

describe Webbed::Method::CONNECT do
  subject { Webbed::Method::CONNECT }
  
  its(:name) { should == 'CONNECT' }
  it { should_not be_safe }
  it { should_not be_idempotent }
  it { should have_entity(:request) }
  it { should have_entity(:response) }
end

describe Webbed::Method::PATCH do
  subject { Webbed::Method::PATCH }
  
  its(:name) { should == 'PATCH' }
  it { should_not be_safe }
  it { should_not be_idempotent }
  it { should have_entity(:request) }
  it { should have_entity(:response) }
end