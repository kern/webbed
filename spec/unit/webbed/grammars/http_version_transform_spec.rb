require "spec_helper"
require "webbed/grammars/http_version_transform"

module Webbed
  module Grammars
    describe HTTPVersionTransform do
      let(:http_version_builder) { double(:http_version_builder) }
      let(:http_version) { double(:http_version) }
      subject(:transform) { HTTPVersionTransform.new(http_version_builder: http_version_builder) }

      it "transforms an HTTP version hash" do
        http_version_builder.stub(:call).with(1, 0) { http_version }
        expect(transform.apply(major_version: "1", minor_version: "0")).to eq(http_version)
      end
    end
  end
end
