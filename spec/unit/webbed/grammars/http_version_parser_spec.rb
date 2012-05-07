require "spec_helper"
require "webbed/grammars/loader"
Webbed::Grammars::Loader.require("http_version")

module Webbed
  module Grammars
    describe HTTPVersionParser do
      subject { HTTPVersionParser.new }

      context "when parsing a valid string" do
        let(:ast) { subject.parse("HTTP/2.14") }

        it "extracts the major version" do
          ast.major.should == 2
        end

        it "extracts the minor version" do
          ast.minor.should == 14
        end
      end

      context "when parsing an invalid string" do
        it "returns nil" do
          subject.parse("HTTP/1").should be_nil
        end
      end
    end
  end
end
