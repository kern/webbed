require "spec_helper"
require "treetop"
require "webbed/grammars/loader"

module Webbed
  module Grammars
    describe Loader do
      before do
        Loader.clear_loaded_grammars
      end

      describe ".require" do
        context "when the grammar doesn't exist" do
          it "raises an error" do
            Treetop.stub(:load).and_raise(Errno::ENOENT)
            expect {
              Loader.require("foobar")
            }.to raise_error(LoadError)
          end
        end

        context "when the grammar exists" do
          context "when the grammar has not been loaded yet" do
            it "requires the grammar" do
              Treetop.should_receive(:load).with("#{Loader::LOAD_PATH}/http_version")
              Loader.require("http_version")
            end

            it "returns true" do
              Treetop.stub(:load)
              Loader.require("http_version").should be_true
            end
          end

          context "when the grammar has already been loaded" do
            it "returns false" do
              Treetop.stub(:load)
              Loader.require("http_version")
              Loader.require("http_version").should be_false
            end
          end
        end
      end
    end
  end
end
