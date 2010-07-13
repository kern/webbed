require 'spec_helper'

describe Webbed::HTTPVersion, 'when created from a HTTP Version string' do
  subject { Webbed::HTTPVersion.new 'HTTP/2.5' }
  
  its(:major) { should == 2 }
  its(:minor) { should == 5 }
  
  
  it 'should have a string representation that is the same as its original representation' do
    subject.to_s.should == 'HTTP/2.5'
  end
  
  context 'when major is 1 and minor is 1' do
    subject { Webbed::HTTPVersion.new 'HTTP/1.1' }
    it { should === Webbed::HTTPVersion::ONE_POINT_ONE }
  end
  
  context 'when major is 1 and minor is 0' do
    subject { Webbed::HTTPVersion.new 'HTTP/1.0' }
    it { should === Webbed::HTTPVersion::ONE_POINT_OH }
  end
end

describe Webbed::HTTPVersion, 'when created with a major and minor number' do
  subject { Webbed::HTTPVersion.new 3.5 }
  
  its(:major) { should == 3 }
  its(:minor) { should == 5 }
  
  context 'when major is 1 and minor is 1' do
    subject { Webbed::HTTPVersion.new 1.1 }
    
    it 'should return Webbed::HTTPVersion::ONE_POINT_ONE' do
      should === Webbed::HTTPVersion::ONE_POINT_ONE
    end
  end
  
  context 'when major is 1 and minor is 0' do
    subject { Webbed::HTTPVersion.new 1.0 }
    
    it 'should return Webbed::HTTPVersion::ONE_POINT_OH' do
      should === Webbed::HTTPVersion::ONE_POINT_OH
    end
  end
end

describe Webbed::HTTPVersion, '#to_f' do
  subject { Webbed::HTTPVersion.new 'HTTP/1.6' }
  
  it 'should return a float of the major and minor numbers' do
    subject.to_f.should == 1.6
  end
end

describe Webbed::HTTPVersion, '#to_s' do
  subject { Webbed::HTTPVersion.new 'HTTP/1.8' }
  
  it 'should concatenate the prefix, major, separator, and minor in that order' do
    subject.to_s.should == 'HTTP/1.8'
  end
end

describe Webbed::HTTPVersion, '#==' do
  subject { Webbed::HTTPVersion.new 'HTTP/1.9' }
  
  it 'should equal the string representation' do
    should == 'HTTP/1.9'
  end
  
  it 'should equal the float representation' do
    should == 1.9
  end
end

describe Webbed::HTTPVersion::ONE_POINT_ONE do
  subject { Webbed::HTTPVersion::ONE_POINT_ONE }
  
  its(:major) { should == 1 }
  its(:minor) { should == 1 }
end

describe Webbed::HTTPVersion::ONE_POINT_OH do
  subject { Webbed::HTTPVersion::ONE_POINT_OH }
  
  its(:major) { should == 1 }
  its(:minor) { should == 0 }
end