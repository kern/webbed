require "spec_helper"
require "webbed/grammars/loader"
Webbed::Grammars::Loader.require("http_version")

module Webbed
  module Grammars
    describe HTTPVersionParser do
      subject { HTTPVersionParser.new }

      describe "#parse" do
        context "when the string can be parsed" do
          let(:ast) { subject.parse("HTTP/2.14") }

          it "has a major version" do
            ast.major.should == 2
          end

          it "has a minor version" do
            ast.minor.should == 14
          end
        end

        context "when the string cannot be parsed" do
          it "returns nil" do
            subject.parse("HTTP/1").should be_nil
          end
        end
      end
    end
  end
end
