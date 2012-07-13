require "spec_helper"
require "webbed/grammars/http_version_parser"

module Webbed
  module Grammars
    describe HTTPVersionParser do
      subject(:parser) { HTTPVersionParser.new }

      it "can parse a valid string" do
        expect(parser).to parse("HTTP/1.0").as({
          major_version: "1",
          minor_version: "0"
        })
      end

      it "cannot parse an invalid string" do
        expect(parser).not_to parse("HTT/1.0")
        expect(parser).not_to parse("HTTP/1.")
        expect(parser).not_to parse("HTTP/1.00")
        expect(parser).not_to parse("HTTP1.0")
        expect(parser).not_to parse("HTTP/A.0")
      end
    end
  end
end
