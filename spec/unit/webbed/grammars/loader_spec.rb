require "spec_helper"
require "treetop"
require "webbed/grammars/loader"

module Webbed
  module Grammars
    describe Loader do
      before do
        Treetop.stub(:load)
        Loader.clear_loaded_grammars
      end

      context "when requiring a grammar that doesn't exist" do
        it "raises an error" do
          Treetop.stub(:load) { raise Errno::ENOENT }
          expect do
            Loader.require("foobar")
          end.to raise_error(LoadError)
        end
      end

      context "when requiring a grammar that does exist" do
        context "when the grammar has not been loaded yet" do
          it "requires the grammar" do
            Treetop.should_receive(:load).with("#{Loader::LOAD_PATH}/http_version")
            Loader.require("http_version")
          end

          it "returns true" do
            Loader.require("http_version").should be_true
          end
        end

        context "when the grammar has already been loaded" do
          it "returns false" do
            Loader.require("http_version")
            Loader.require("http_version").should be_false
          end
        end
      end
    end
  end
end
