require 'spec_helper'

describe Webbed::Extensions::MethodAliases do
  context 'when the request uses a safe method' do
    subject { Webbed::Request.new :method => 'GET' }
    
    it { should be_safe }
    it { should_not be_unsafe }
    it { should be_idempotent }
    it { should_not be_nonidempotent }
  end
  
  context 'when the request uses an idempotent method' do
    subject { Webbed::Request.new :method => 'PUT' }
    
    it { should_not be_safe }
    it { should be_unsafe }
    it { should be_idempotent }
    it { should_not be_nonidempotent }
  end
  
  context 'when the request uses a nonidempotent method' do
    subject { Webbed::Request.new :method => 'POST' }
    
    it { should_not be_safe }
    it { should be_unsafe }
    it { should_not be_idempotent }
    it { should be_nonidempotent }
  end
end