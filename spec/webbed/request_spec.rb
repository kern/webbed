require 'spec_helper'

describe Webbed::Request do
  before do
    @request = Webbed::Request.new
  end
  
  subject { @request }
  
  it 'should include Webbed::GenericMessage' do
    Webbed::Request.ancestors.should include(Webbed::GenericMessage)
  end
  
  context 'upon creation' do
    describe 'request line' do
      subject { @request.request_line }
      it { should be_an_instance_of(Webbed::RequestLine) }
      
      describe 'method' do
        subject { @request.request_line.method }
        it { should == Webbed::Method::GET }
      end
      
      describe 'request URI' do
        subject { @request.request_line.request_uri.to_s }
        it { should == '*' }
      end
      
      describe 'HTTP version' do
        subject { @request.request_line.http_version }
        it { should == 'HTTP/1.1' }
      end
    end
  end
end

describe Webbed::Request, 'start line' do
  before do
    @request = Webbed::Request.new
  end
  
  subject { @request }
  
  it 'should be the same as the request line' do
    @request.start_line.should equal(@request.request_line)
  end
end