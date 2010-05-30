require 'spec_helper'

describe Webbed::RequestLine, 'created without arguments' do
  before do
    @request_line = Webbed::RequestLine.new
  end
  
  subject { @request_line }
  
  describe 'method' do
    subject { @request_line.method }
    it { should == Webbed::Method::GET }
  end
  
  describe 'request URI' do
    subject { @request_line.request_uri }
    
    it { should be_an_instance_of(Addressable::URI) }
    specify { subject.to_s.should == '*' }
  end
  
  describe 'HTTP version' do
    subject { @request_line.http_version }
    it { should == 'HTTP/1.1' }
  end
end

describe Webbed::RequestLine, 'created with a method' do
  before do
    @request_line = Webbed::RequestLine.new(Webbed::Method::POST)
  end
  
  subject { @request_line }
  
  describe 'method' do
    subject { @request_line.method }
    it 'should be stored' do
      should == Webbed::Method::POST
    end
  end
end

describe Webbed::RequestLine, 'created with a method name' do
  before do
    @request_line = Webbed::RequestLine.new('POST')
  end
  
  subject { @request_line }
  
  describe 'method' do
    subject { @request_line.method }
    it 'should be stored with the looked up method' do
      should == Webbed::Method::POST
    end
  end
end

describe Webbed::RequestLine, 'created with a request URI' do
  before do
    @request_line = Webbed::RequestLine.new('POST', '/test')
  end
  
  subject { @request_line }
  
  describe 'request URI' do
    subject { @request_line.request_uri }
    
    it { should be_an_instance_of(Addressable::URI) }
    
    it 'should be stored' do
      subject.to_s.should == '/test'
    end
  end
end

describe Webbed::RequestLine, 'created with a HTTP version' do
  before do
    @request_line = Webbed::RequestLine.new('POST', '/', Webbed::HTTPVersion.new(1, 2))
  end
  
  subject { @request_line }
  
  describe 'HTTP version' do
    subject { @request_line.http_version }
    
    it 'should be stored as an HTTPVersion' do
      should == 'HTTP/1.2'
    end
  end
end

describe Webbed::RequestLine, '#to_s' do
  before do
    @request_line = Webbed::RequestLine.new
  end
  
  subject { @request_line }
  
  it 'should use the method' do
    subject.method.should_receive(:to_s)
    subject.to_s
  end
  
  it 'should use the request URI' do
    subject.request_uri.should_receive(:to_s)
    subject.to_s
  end
  
  it 'should use the HTTP version' do
    subject.http_version.should_receive(:to_s)
    subject.to_s
  end
  
  it 'should be correct' do
    subject.to_s.should == "GET * HTTP/1.1\r\n"
  end
end

describe Webbed::RequestLine do
  before do
    @request_line = Webbed::RequestLine.new
  end
  
  subject { @request_line }
  
  describe 'method' do
    subject { @request_line.method }
    
    it 'should be settable with a method' do
      @request_line.method = Webbed::Method::POST
      subject.should == Webbed::Method::POST
    end
    
    it 'should be settable with a method name' do
      @request_line.method = 'POST'
      subject.should == Webbed::Method::POST
    end
  end
  
  describe 'request URI' do
    subject { @request_line.request_uri }
    
    it { should be_an_instance_of(Addressable::URI) }
    
    it 'should be settable with an Addressable::URI' do
      @request_line.request_uri = Addressable::URI.parse('http://google.com/')
      subject.to_s.should == 'http://google.com/'
    end
    
    it 'should be settable with a string' do
      @request_line.request_uri = '/foo'
      subject.to_s.should == '/foo'
    end
  end
  
  describe 'HTTP version' do
    subject { @request_line.http_version }
    it 'should be settable' do
      @request_line.http_version = Webbed::HTTPVersion.new(1, 2)
      subject.should == 'HTTP/1.2'
    end
  end
end