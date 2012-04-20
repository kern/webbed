require "spec_helper"
require "webbed/grammars/loader"
Webbed::Grammars::Loader.require("http_version")

describe Webbed::Grammars::HTTPVersionParser do
  let(:parser) { Webbed::Grammars::HTTPVersionParser.new }
  subject { parser }

  context "when the string is a valid HTTP version" do
    subject { parser.parse("HTTP/2.14") }

    it "sets the major version" do
      subject.major.should == 2
    end

    it "correctly sets the minor version" do
      subject.minor.should == 14
    end
  end

  context "when the the string is an invalid HTTP version" do
    it "returns nil" do
      subject.parse("HTTP/1").should be_nil
    end
  end
end
