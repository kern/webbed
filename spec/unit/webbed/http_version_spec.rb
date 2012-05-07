require "spec_helper"
require "webbed/http_version"

module Webbed
  describe HTTPVersion do
    subject { HTTPVersion.new(1, 1) }

    describe ".parse" do
      let(:parser) { double("parser") }
      let(:node) { double("node") }
      let(:parsed_version) { HTTPVersion.parse("HTTP/2.14", parser) }

      before do
        parser.stub(:parse).with("HTTP/2.14").and_return(node)
        node.stub(:major).and_return(2)
        node.stub(:minor).and_return(14)
      end
      
      it "parses the major version" do
        parsed_version.major.should == 2
      end

      it "parses the minor version" do
        parsed_version.minor.should == 14
      end
    end

    it "can be compared to other HTTP versions based on its major and minor versions" do
      subject.should == HTTPVersion.new(1, 1)
      subject.should > HTTPVersion.new(0, 9)
      subject.should < HTTPVersion.new(2, 0)
    end
  end
end
