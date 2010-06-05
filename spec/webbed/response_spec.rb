require 'spec_helper'

describe Webbed::Response do
  before do
    @response = Webbed::Response.new
  end
  
  subject { @response }
  
  it 'should include Webbed::GenericMessage' do
    Webbed::Response.ancestors.should include(Webbed::GenericMessage)
  end
  
  context 'upon creation' do
    describe 'status line' do
      subject { @response.status_line }
      it { should be_an_instance_of(Webbed::StatusLine) }
      
      describe 'status code' do
        subject { @response.status_line.status_code }
        it { should == 200 }
      end
      
      describe 'reason phrase' do
        subject { @response.status_line.reason_phrase }
        it { should == 'OK' }
      end
      
      describe 'HTTP version' do
        subject { @response.status_line.http_version }
        it { should == 'HTTP/1.1' }
      end
    end
  end
end

describe Webbed::Response, 'start line' do
  before do
    @response = Webbed::Response.new
  end
  
  subject { @response }
  
  it 'should be the same as the status line' do
    @response.start_line.should equal(@response.status_line)
  end
end