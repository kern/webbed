require "spec_helper"
require "webbed/http_version"

module Webbed
  describe HTTPVersion do
    subject { HTTPVersion.new(1, 0) }

    it "has a major version" do
      subject.major.should == 1
    end

    it "has a minor version" do
      subject.minor.should == 0
    end

    describe "parsing" do
      let(:parser) { double("parser") }
      let(:ast) { double("node", major: 2, minor: 14) }
      subject { HTTPVersion.parse("HTTP/2.14", parser) }

      before do
        parser.stub(:parse).with("HTTP/2.14") { ast }
      end
      
      it "parses the major version" do
        subject.major.should == 2
      end

      it "parses the minor version" do
        subject.minor.should == 14
      end

      it "cannot parse invalid versions" do
        expect do
          HTTPVersion.parse("HTTP/2")
        end.to raise_error(InvalidFormat)
      end
    end

    it "can be compared to other HTTP versions based on its major and minor versions" do
      subject.should == HTTPVersion.new(1, 0)
      subject.should > HTTPVersion.new(0, 9)
      subject.should < HTTPVersion.new(2, 0)
    end
  end
end
