require 'spec_helper'

describe Webbed::Helpers::RequestUriHelper do
  subject { Webbed::Request.new }
  
  it 'should alias #uri, #url, and #request_url all to #request_uri' do
    @request_uri = subject.method(:request_uri)
    @request_uri.should == subject.method(:uri)
    @request_uri.should == subject.method(:url)
    @request_uri.should == subject.method(:request_url)
  end
end