require 'spec_helper'

describe Webbed::ReasonPhrase do
  subject { Webbed::ReasonPhrase.new('Foo Bar') }
  
  context 'when created with a successful status code' do
    subject { Webbed::ReasonPhrase.new(200) }
    
    it 'should store the status code default reason phrase' do
      subject.reason_phrase.should == 'OK'
    end
  end
  
  context 'when created with an error status code' do
    subject { Webbed::ReasonPhrase.new(400) }
    
    it 'should store the status code default reason phrase' do
      subject.reason_phrase.should == 'Bad Request'
    end
  end
  
  context 'when created with an unknown status code' do
    subject { Webbed::ReasonPhrase.new(600) }
    
    it 'should default to unknown' do
      subject.reason_phrase.should == 'Unknown'
    end
  end
  
  context 'when created with a reason phrase' do
    it 'should store that reason phrase' do
      subject.reason_phrase.should == 'Foo Bar'
    end
  end
  
  describe '#to_s' do
    it 'should return the reason phrase' do
      subject.to_s.should == 'Foo Bar'
    end
  end
  
  describe '#==' do
    it 'should be equal to a reason phrase that is identical' do
      subject.should == Webbed::ReasonPhrase.new('Foo Bar')
    end
    
    it 'should not be equal to a reason phrase that is different' do
      subject.should_not == Webbed::ReasonPhrase.new('Bar Foo')
    end
    
    it 'should be equal to the string of the reason phrase' do
      subject.should == 'Foo Bar'
    end
    
    it 'should not be equal to any other string' do
      subject.should_not == 'Bar Foo'
    end
  end
end