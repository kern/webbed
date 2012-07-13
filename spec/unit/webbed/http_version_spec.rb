require "spec_helper"
require "webbed/http_version"

module Webbed
  describe HTTPVersion do
    subject(:version) { HTTPVersion.new(1, 0) }

    it "has a major version" do
      expect(version.major_version).to eq(1)
    end

    it "has a minor version" do
      expect(version.minor_version).to eq(0)
    end

    describe "parsing" do
      let(:interpreter) { double(:interpreter) }

      it "interprets the HTTP version" do
        interpreter.stub(:interpret).with("HTTP/2.0") { "abc" }
        expect(HTTPVersion.interpret("HTTP/2.0", interpreter)).to eq("abc")
      end
    end

    it "can be compared to other HTTP versions based on its major and minor versions" do
      expect(version).to eq(HTTPVersion.new(1, 0))
      expect(version).to be > HTTPVersion.new(0, 9)
      expect(version).to be < HTTPVersion.new(2, 0)
    end
  end
end
