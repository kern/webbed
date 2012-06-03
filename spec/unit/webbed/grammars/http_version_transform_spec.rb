require "spec_helper"
require "webbed/grammars/http_version_transform"
require "webbed/http_version"

module Webbed
  module Grammars
    describe HTTPVersionTransform do
      let(:transform) { HTTPVersionTransform.new }

      it "transforms an HTTP version hash" do
        transform.apply(major_version: "1", minor_version: "0").should == HTTPVersion::ONE_POINT_OH
      end
    end
  end
end
