require "spec_helper"
require "webbed/registry"

module Webbed
  describe Registry do
    it_behaves_like "a registry" do
      subject(:registry) { Registry.new { |o| 123 } }
      let(:lookup_key) { 123 }
      let(:obj1) { double(:obj1) }
      let(:obj2) { double(:obj2) }
    end
  end
end
