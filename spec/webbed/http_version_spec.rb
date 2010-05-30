require 'spec_helper'

describe Webbed::HTTPVersion, 'created without a major and minor number' do
  before do
    @version = Webbed::HTTPVersion.new
  end
  
  subject { @version }
  
  describe 'major number' do
    subject { @version.major }
    it { should == 1 }
  end
  
  describe 'minor number' do
    subject { @version.minor }
    it { should == 1 }
  end
end

describe Webbed::HTTPVersion, 'created with both a major and minor number' do
  before do
    @version = Webbed::HTTPVersion.new(2, 0)
  end
  
  describe 'major number' do
    subject { @version.major }
    it 'should be stored' do
      should == 2
    end
  end
  
  describe 'minor number' do
    subject { @version.minor }
    it 'should be stored' do
      should == 0
    end
  end
end

describe Webbed::HTTPVersion, '#to_s' do
  before do
    @version = Webbed::HTTPVersion.new
  end
  
  subject { @version }
  
  it 'shoud use the major number to create the version string' do
    subject.should_receive(:major).and_return(1)
    subject.to_s
  end
  
  it 'shoud use the minor number to create the version string' do
    subject.should_receive(:minor).and_return(1)
    subject.to_s
  end
  
  it 'should add the separators in between the digits' do
    subject.to_s.should == 'HTTP/1.1'
  end
end

describe Webbed::HTTPVersion, 'equality' do
  before do
    @version = Webbed::HTTPVersion.new
  end
  
  subject { @version }
  
  it 'should equal the stringified version' do
    should == 'HTTP/1.1'
  end
  
  it 'should equal an identcal version' do
    should == Webbed::HTTPVersion.new
  end
  
  it 'should not equal a different string version' do
    should_not == 'HTTP/1.0'
  end
  
  it 'should not equal a different version' do
    should_not == Webbed::HTTPVersion.new(1, 2)
  end
end