require 'spec_helper'

describe Webbed::Headers do
  it { should be_a_kind_of(CICPHash) }
  
  context 'when created without arguments' do
    subject { Webbed::Headers.new }
    it { should be_empty }
  end
  
  context 'when created with headers' do
    subject do
      Webbed::Headers.new(
        'Content-Type' => 'application/json',
        'Host' => 'foo.com'
      )
    end
    
    it { should_not be_empty }
    
    it 'should store the headers' do
      subject['Content-Type'].should == 'application/json'
      subject['Host'].should == 'foo.com'
    end
  end
  
  describe '#to_s' do
    before do
      @headers = Webbed::Headers.new(
        'Content-Type' => 'application/json',
        'Host' => 'foo.com'
      )
      @headers.stubs(:[]).returns('foo')
      @string = @headers.to_s
    end
    
    it 'should use each field content' do
      @headers.should have_received(:[]).twice
    end
    
    it 'should be correct according to RFC 2616' do
      @string.should == "Content-Type: foo\r\nHost: foo\r\n"
    end
  end
end