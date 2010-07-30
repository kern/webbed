require 'spec_helper'

describe Webbed::Helpers::MethodHelper do
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
  
  context 'when the request uses OPTIONS' do
    subject { Webbed::Request.new :method => 'OPTIONS' }
    
    it { should be_options }
    it { should_not be_get }
    it { should_not be_head }
    it { should_not be_post }
    it { should_not be_put }
    it { should_not be_delete }
    it { should_not be_trace }
    it { should_not be_connect }
    it { should_not be_patch }
  end
  
  context 'when the request uses GET' do
    subject { Webbed::Request.new :method => 'GET' }
    
    it { should_not be_options }
    it { should be_get }
    it { should_not be_head }
    it { should_not be_post }
    it { should_not be_put }
    it { should_not be_delete }
    it { should_not be_trace }
    it { should_not be_connect }
    it { should_not be_patch }
  end
  
  context 'when the request uses HEAD' do
    subject { Webbed::Request.new :method => 'HEAD' }
    
    it { should_not be_options }
    it { should_not be_get }
    it { should be_head }
    it { should_not be_post }
    it { should_not be_put }
    it { should_not be_delete }
    it { should_not be_trace }
    it { should_not be_connect }
    it { should_not be_patch }
  end
  
  context 'when the request uses POST' do
    subject { Webbed::Request.new :method => 'POST' }
    
    it { should_not be_options }
    it { should_not be_get }
    it { should_not be_head }
    it { should be_post }
    it { should_not be_put }
    it { should_not be_delete }
    it { should_not be_trace }
    it { should_not be_connect }
    it { should_not be_patch }
  end
  
  context 'when the request uses PUT' do
    subject { Webbed::Request.new :method => 'PUT' }
    
    it { should_not be_options }
    it { should_not be_get }
    it { should_not be_head }
    it { should_not be_post }
    it { should be_put }
    it { should_not be_delete }
    it { should_not be_trace }
    it { should_not be_connect }
    it { should_not be_patch }
  end
  
  context 'when the request uses DELETE' do
    subject { Webbed::Request.new :method => 'DELETE' }
    
    it { should_not be_options }
    it { should_not be_get }
    it { should_not be_head }
    it { should_not be_post }
    it { should_not be_put }
    it { should be_delete }
    it { should_not be_trace }
    it { should_not be_connect }
    it { should_not be_patch }
  end
  
  context 'when the request uses TRACE' do
    subject { Webbed::Request.new :method => 'TRACE' }
    
    it { should_not be_options }
    it { should_not be_get }
    it { should_not be_head }
    it { should_not be_post }
    it { should_not be_put }
    it { should_not be_delete }
    it { should be_trace }
    it { should_not be_connect }
    it { should_not be_patch }
  end
  
  context 'when the request uses CONNECT' do
    subject { Webbed::Request.new :method => 'CONNECT' }
    
    it { should_not be_options }
    it { should_not be_get }
    it { should_not be_head }
    it { should_not be_post }
    it { should_not be_put }
    it { should_not be_delete }
    it { should_not be_trace }
    it { should be_connect }
    it { should_not be_patch }
  end
  
  context 'when the request uses PATCH' do
    subject { Webbed::Request.new :method => 'PATCH' }
    
    it { should_not be_options }
    it { should_not be_get }
    it { should_not be_head }
    it { should_not be_post }
    it { should_not be_put }
    it { should_not be_delete }
    it { should_not be_trace }
    it { should_not be_connect }
    it { should be_patch }
  end
end