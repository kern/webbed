require "spec_helper"
require "webbed/http_version"

module Webbed
  describe HTTPVersion do
    subject { HTTPVersion.new(1, 0) }

    it "has a major version" do
      subject.major_version.should == 1
    end

    it "has a minor version" do
      subject.minor_version.should == 0
    end

    describe "parsing" do
      let(:interpreter) { double(:interpreter) }

      it "interprets the HTTP version" do
        interpreter.stub(:interpret).with("HTTP/2.0") { "abc" }
        HTTPVersion.interpret("HTTP/2.0", interpreter).should == "abc"
      end
    end

    it "can be compared to other HTTP versions based on its major and minor versions" do
      subject.should == HTTPVersion.new(1, 0)
      subject.should > HTTPVersion.new(0, 9)
      subject.should < HTTPVersion.new(2, 0)
    end
  end
end
