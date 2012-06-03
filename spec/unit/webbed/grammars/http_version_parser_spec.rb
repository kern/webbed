require "spec_helper"
require "parslet/rig/rspec"
require "webbed/grammars/http_version_parser"

module Webbed
  module Grammars
    describe HTTPVersionParser do
      let(:parser) { HTTPVersionParser.new }

      it "can parse a valid string" do
        parser.should parse("HTTP/1.0").as({
          major_version: "1",
          minor_version: "0"
        })
      end

      it "cannot parse an invalid string" do
        parser.should_not parse("HTT/1.0")
        parser.should_not parse("HTTP/1.")
        parser.should_not parse("HTTP/1.00")
        parser.should_not parse("HTTP1.0")
        parser.should_not parse("HTTP/A.0")
      end
    end
  end
end
