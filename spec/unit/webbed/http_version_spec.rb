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
    let(:http_version) { Webbed::HTTPVersion.parse("HTTP/1.1") }
    
    it "sets the major version" do
      subject.major.should == 1
    end

    it "sets the minor version" do
      subject.major.should == 1
    end
  end
end
