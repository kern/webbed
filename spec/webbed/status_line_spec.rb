require 'spec_helper'

describe Webbed::StatusLine, 'created without arguments' do
  before do
    @status_line = Webbed::StatusLine.new
  end
  
  subject { @status_line }
  
  describe 'status code' do
    subject { @status_line.status_code }
    it { should be_an_instance_of(Webbed::StatusCode) }
    it { should == 200 }
  end
  
  describe 'reason phrase' do
    subject { @status_line.reason_phrase }
    it { should be_an_instance_of(Webbed::ReasonPhrase) }
    it { should == 'OK' }
  end
  
  describe 'HTTP version' do
    subject { @status_line.http_version }
    it { should be_an_instance_of(Webbed::HTTPVersion) }
    it { should == 'HTTP/1.1' }
  end
end

describe Webbed::StatusLine, 'created with a status code' do
  before do
    @status_line = Webbed::StatusLine.new(400)
  end
  
  subject { @status_line }
  
  describe 'status code' do
    subject { @status_line.status_code }
    
    it { should be_an_instance_of(Webbed::StatusCode) }
    
    it 'should be stored' do
      should == 400
    end
  end
  
  describe 'reason phrase' do
    subject { @status_line.reason_phrase }
    
    it { should be_an_instance_of(Webbed::ReasonPhrase) }
    
    it 'should be the default reason phrase for the status code' do
      should == 'Bad Request'
    end
  end
end

describe Webbed::StatusLine, 'created with a reason phrase' do
  before do
    @status_line = Webbed::StatusLine.new(200, 'Fake Phrase')
  end
  
  subject { @status_line }
  
  describe 'reason phrase' do
    subject { @status_line.reason_phrase }
    
    it { should be_an_instance_of(Webbed::ReasonPhrase) }
    
    it 'should be stored' do
      should == 'Fake Phrase'
    end
  end
end

describe Webbed::StatusLine, 'created with an HTTP version' do
  before do
    @status_line = Webbed::StatusLine.new(200, 'Fake Phrase', Webbed::HTTPVersion.new(1, 2))
  end
  
  subject { @status_line }
  
  describe 'HTTP version' do
    subject { @status_line.http_version }
    
    it { should be_an_instance_of(Webbed::HTTPVersion) }
    
    it 'should be stored' do
      should == 'HTTP/1.2'
    end
  end
end


describe Webbed::StatusLine, '#to_s' do
  before do
    @status_line = Webbed::StatusLine.new
  end
  
  subject{ @status_line }
  
  it 'should use the status code' do
    subject.status_code.should_receive(:to_s)
    subject.to_s
  end
  
  it 'should use the reason phrase' do
    subject.reason_phrase.should_receive(:to_s)
    subject.to_s
  end
  
  it 'should use the HTTP version' do
    subject.http_version.should_receive(:to_s)
    subject.to_s
  end
  
  it 'should be correct' do
    subject.to_s.should == "HTTP/1.1 200 OK\r\n"
  end
end