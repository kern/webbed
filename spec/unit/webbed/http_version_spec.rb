require "spec_helper"
require "webbed/http_version"

describe Webbed::HTTPVersion do
  let(:http_version) { Webbed::HTTPVersion.new(1, 1) }
  subject { http_version }
  
  describe "#initialize" do
    it "sets the major version" do
      subject.major.should == 1
    end

    it "sets the minor version" do
      subject.minor.should == 1
    end
  end

  describe ".parse" do
    let(:parser) { double("parser") }
    let(:node) { double("node") }
    let(:http_version) { Webbed::HTTPVersion.parse("HTTP/2.14", parser) }

    before do
      parser.stub(:parse).with("HTTP/2.14").and_return(node)
      node.stub(:major).and_return(2)
      node.stub(:minor).and_return(14)
    end
    
    it "sets the major version" do
      subject.major.should == 2
    end

    it "sets the minor version" do
      subject.minor.should == 14
    end
  end

  specify "equality" do
    subject.should == Webbed::HTTPVersion.new(1, 1)
    subject.should > Webbed::HTTPVersion.new(0, 9)
    subject.should < Webbed::HTTPVersion.new(2, 0)
  end

  describe "ONE_POINT_ONE" do
    let(:http_version) { Webbed::HTTPVersion::ONE_POINT_ONE }

    it "has a major version of 1" do
      subject.major.should == 1
    end

    it "has a minor version of 1" do
      subject.minor.should == 1
    end
  end

  describe "ONE_POINT_OH" do
    let(:http_version) { Webbed::HTTPVersion::ONE_POINT_OH }

    it "has a major version of 1" do
      subject.major.should == 1
    end

    it "has a minor version of 0" do
      subject.minor.should == 0
    end
  end
end
