require 'spec_helper'

shared_examples_for "HTTP/1.1" do
  it "should set #major" do
    subject.major.should == 1
  end
  
  it "should set #minor" do
    subject.minor.should == 1
  end
end

describe Webbed::HTTPVersion do
  before do
    @one_point_oh = Webbed::HTTPVersion.new 'HTTP/1.0'
    @one_point_one = Webbed::HTTPVersion.new 'HTTP/1.1'
  end
  
  context "when created with a String" do
    subject { @one_point_one }
    it_should_behave_like 'HTTP/1.1'
  end
  
  context "when created with a Float" do
    subject { Webbed::HTTPVersion.new 1.1 }
    it_should_behave_like 'HTTP/1.1'
  end
  
  describe "#to_f" do
    it "should convert to a Float" do
      @one_point_one.should == 1.1
    end
  end
  
  describe "#to_s" do
    it "should convert to a String" do
      @one_point_oh.to_s.should == 'HTTP/1.0'
    end
  end
  
  describe "#<=>" do
    it "should equal the same version" do
      @one_point_oh.should == 1.0
    end
    
    it "should be less than a bigger version" do
      @one_point_oh.should < 2.0
    end
    
    it "should be greater than a smaller version" do
      @one_point_oh.should > 0.9
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