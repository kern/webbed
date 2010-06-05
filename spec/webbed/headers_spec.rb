require 'spec_helper'

describe Webbed::Headers, 'created without arguments' do
  before do
    @header_group = Webbed::Headers.new
  end
  
  subject { @header_group }
  
  it { should be_empty }
  it { should be_a_kind_of(CICPHash) }
end

describe Webbed::Headers, 'created with headers' do
  before do
    @header_group = Webbed::Headers.new('Content-Type' => 'application/json',
                                            'Host' => 'foo.com')
  end
  
  subject { @header_group }
  
  it { should_not be_empty }
  it { should be_a_kind_of(CICPHash) }
  
  it 'should store the headers' do
    @header_group.should include('Content-Type', 'Host')
  end
  
  it 'should give each header the proper field content' do
    @header_group['Content-Type'].should == 'application/json'
  end
end

describe Webbed::Headers, '#add' do
  context 'when no headers with the same field name exist' do
    before do
      @header_group = Webbed::Headers.new
    end
    
    it 'should add the header to the end separated by a comma' do
      @header_group.add('Link', 'fake')
      @header_group['Link'].should == 'fake'
    end
    
    it 'should strip the whitespace' do
      @header_group.add('Link', ' fake ')
      @header_group['Link'].should == 'fake'
    end
  end
  
  context 'when a header with the same field name exists' do
    before do
      @header_group = Webbed::Headers.new('Link' => 'fake_link')
    end
    
    it 'should add the header to the end separated by a comma' do
      @header_group.add('Link', 'second_fake')
      @header_group['Link'].should == 'fake_link,second_fake'
    end
    
    it 'should strip LWS' do
      @header_group.add('Link', ' second ')
      @header_group['Link'].should == 'fake_link,second'
    end
  end
end

describe Webbed::Headers, '#[]=' do
  before do
    @header_group = Webbed::Headers.new
  end
  
  subject { @header_group }
  
  context 'when it has LWS' do
    before do
      @header_group['Content-Type'] = ' application/json '
    end
    
    it 'should strip the whitespace' do
      @header_group['Content-Type'].should == 'application/json'
    end
  end
end

describe Webbed::Headers, '#to_s' do
  before do
    @header_group = Webbed::Headers.new('Content-Type' => 'application/json',
                                            'Host' => 'foo.com')
  end
  
  subject { @header_group }
  
  it 'should use each field content' do
    @header_group.each do |field_name, field_content|
      @header_group.should_receive(:[]).with(field_name).once.and_return(field_content)
    end
    
    @header_group.to_s
  end
  
  it 'should be correct according to RFC 2616' do
    @header_group.to_s.should == "Content-Type: application/json\r\nHost: foo.com\r\n"
  end
end