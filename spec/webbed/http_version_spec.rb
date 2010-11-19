require 'spec_helper'

describe Webbed::HTTPVersion do
  let(:one_point_oh) { Webbed::HTTPVersion.new 'HTTP/1.0' }
  let(:one_point_one) { Webbed::HTTPVersion.new 'HTTP/1.1' }
  let(:two_point_oh) { Webbed::HTTPVersion.new 'HTTP/2.0' }
  
  context "when created from a HTTP Version string" do
    it "should set the major number" do
      one_point_one.major.should == 1
    end
    
    it "should set the minor number" do
      one_point_one.minor.should == 1
    end
  end
  
  context "when created with a major and minor number" do
    let(:three_point_five) { Webbed::HTTPVersion.new 3.5 }
    
    it "should set the major number" do
      three_point_five.major.should == 3
    end
    
    it "should set the minor number" do
      three_point_five.minor.should == 5
    end
  end
  
  describe "#to_f" do
    it "should convert to a Float" do
      one_point_one.should == 1.1
    end
  end
  
  describe "#to_s" do
    it "should concatenate the prefix, major, separator, and minor" do
      one_point_oh.to_s.should == 'HTTP/1.0'
    end
  end
  
  describe "#<=>" do
    it "should equal the same version" do
      one_point_oh.should == 1.0
    end
    
    it "should be less than a bigger version" do
      one_point_oh.should < 2.0
    end
    
    it "should be greater than a smaller version" do
      one_point_oh.should > 0.9
    end
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