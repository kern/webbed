require 'spec_helper'

describe Webbed::Helpers::MethodHelper do
  before do
    @options = Webbed::Request.new ['OPTIONS', '*', 'HTTP/1.1', {}, '']
    @get = Webbed::Request.new ['GET', '*', 'HTTP/1.1', {}, '']
    @head = Webbed::Request.new ['HEAD', '*', 'HTTP/1.1', {}, '']
    @post = Webbed::Request.new ['POST', '*', 'HTTP/1.1', {}, '']
    @put = Webbed::Request.new ['PUT', '*', 'HTTP/1.1', {}, '']
    @delete = Webbed::Request.new ['DELETE', '*', 'HTTP/1.1', {}, '']
    @trace = Webbed::Request.new ['TRACE', '*', 'HTTP/1.1', {}, '']
    @connect = Webbed::Request.new ['CONNECT', '*', 'HTTP/1.1', {}, '']
    @patch = Webbed::Request.new ['PATCH', '*', 'HTTP/1.1', {}, '']
  end
  
  context "when the request uses a safe method" do
    subject { @get }
    it { should be_safe }
    it { should be_idempotent }
  end
  
  context "when the request uses an idempotent method" do
    subject { @put }
    it { should_not be_safe }
    it { should be_idempotent }
  end
  
  context "when the request uses a nonidempotent method" do
    subject { @post }
    it { should_not be_safe }
    it { should_not be_idempotent }
  end
  
  context "when the request uses OPTIONS" do
    subject { @options }
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
  
  context "when the request uses GET" do
    subject { @get }
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
  
  context "when the request uses HEAD" do
    subject { @head }
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
  
  context "when the request uses POST" do
    subject { @post }
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
  
  context "when the request uses PUT" do
    subject { @put }
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
  
  context "when the request uses DELETE" do
    subject { @delete }
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
  
  context "when the request uses TRACE" do
    subject { @trace }
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
  
  context "when the request uses CONNECT" do
    subject { @connect }
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
  
  context "when the request uses PATCH" do
    subject { @patch }
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