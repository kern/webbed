require 'spec_helper'

describe Webbed::ReasonPhrase, 'created with a known status code' do
  before do
    @reason_phrase = Webbed::ReasonPhrase.new(200)
  end
  
  subject { @reason_phrase }
  
  it 'should look up the default reason phrase' do
    Webbed::ReasonPhrase::REASON_PHRASES.should_receive(:[]).with(200)
    Webbed::ReasonPhrase.new(200)
  end
  
  describe 'reason phrase' do
    subject { @reason_phrase.reason_phrase }
    it 'should be stored with the default status code reason phrase' do
      should == 'OK'
    end
  end
end

describe Webbed::ReasonPhrase, 'created with an unknown status code' do
  before do
    @reason_phrase = Webbed::ReasonPhrase.new(600)
  end
  
  subject { @reason_phrase }
  
  it 'should attempt to look up the default reason phrase' do
    Webbed::ReasonPhrase::REASON_PHRASES.should_receive(:[]).with(600)
    Webbed::ReasonPhrase.new(600)
  end
  
  describe 'reason phrase' do
    subject { @reason_phrase.reason_phrase }
    it { should == 'Unknown' }
  end
end

describe Webbed::ReasonPhrase, 'created with a reason phrase' do
  before do
    @reason_phrase = Webbed::ReasonPhrase.new('Foo Bar')
  end
  
  subject { @reason_phrase }
  
  describe 'reason_phrase' do
    subject { @reason_phrase.reason_phrase }
    it 'should be stored' do
      should == 'Foo Bar'
    end
  end
end

describe Webbed::ReasonPhrase, 'equality' do
  before do
    @reason_phrase = Webbed::ReasonPhrase.new(200)
  end
  
  subject { @reason_phrase }
  
  it 'should equal the same stringified reason phrase' do
    should == 'OK'
  end
  
  it 'should equal an identical reason phrase' do
    should == Webbed::ReasonPhrase.new(200)
  end
  
  it 'should not equal a different string' do
    should_not == 'Foo Bar'
  end
  
  it 'should not equal any other reason phrase' do
    should_not == Webbed::ReasonPhrase.new(400)
  end
end

describe Webbed::ReasonPhrase, '#to_s' do
  before do
    @reason_phrase = Webbed::ReasonPhrase.new(200)
  end
  
  subject { @reason_phrase }

  it 'should return the reason phrase' do
    subject.to_s.should == 'OK'
  end
end