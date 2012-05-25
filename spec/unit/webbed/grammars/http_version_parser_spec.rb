require "spec_helper"
require "parslet/rig/rspec"
require "webbed/grammars/http_version_parser"

module Webbed
  module Grammars
    describe HTTPVersionParser do
      subject { HTTPVersionParser.new }

      it "can parse a valid string" do
        subject.should parse("HTTP/1.0").as({
          major_version: "1",
          minor_version: "0"
        })
      end

      it "cannot parse an invalid string" do
        subject.should_not parse("HTT/1.0")
        subject.should_not parse("HTTP/1.")
        subject.should_not parse("HTTP/1.00")
        subject.should_not parse("HTTP1.0")
        subject.should_not parse("HTTP/A.0")
      end
    end
  end
end
