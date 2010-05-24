require 'spec_helper'

describe Webbed::HTTPVersion do
  context 'when created without a major and minor number' do
    subject { Webbed::HTTPVersion.new }
    specify { subject.major.should == 1 }
    specify { subject.minor.should == 1 }
  end
  
  context 'when created with both a major and minor number' do
    subject { Webbed::HTTPVersion.new(2, 0) }
    
    it 'should set the major number' do
      subject.major.should == 2
    end
    
    it 'should set the minor number' do
      subject.minor.should == 0
    end
  end
  
  describe '#to_s' do
    before do
      @version = Webbed::HTTPVersion.new
    end
    
    it 'shoud use the major number to create the version string' do
      @version.should_receive(:major).and_return(1)
      @version.to_s
    end
    
    it 'shoud use the minor number to create the version string' do
      @version.should_receive(:minor).and_return(1)
      @version.to_s
    end
    
    it 'should add the separators in between the digits' do
      @version.to_s.should == 'HTTP/1.1'
    end
  end
  
  describe '#==' do
    it 'should be the same as a generated string' do
      Webbed::HTTPVersion.new(1, 2).should == 'HTTP/1.2'
    end
    
    it 'should not be equal to a different string' do
      Webbed::HTTPVersion.new(1, 2).should_not == 'HTTP/1.1'
    end
    
    it 'should be equal to another version with the same numbers' do
      Webbed::HTTPVersion.new.should == Webbed::HTTPVersion.new
    end
    
    it 'should not be equal to another version with different numbers' do
      Webbed::HTTPVersion.new.should_not == Webbed::HTTPVersion.new(1, 2)
    end
  end
end