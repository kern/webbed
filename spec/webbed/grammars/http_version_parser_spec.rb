require "spec_helper"

describe Webbed::Grammars::HTTPVersionParser do
  let(:parser) { Webbed::Grammars::HTTPVersionParser.new }

  it "parses a valid HTTP Version" do
    result = parser.parse("HTTP/2.14").value
    result.should == [2, 14]
  end

  it "cannot parse an invalid HTTP Version" do
    parser.parse("HTTP/1").should be_nil
  end
end
