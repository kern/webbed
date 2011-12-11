require "spec_helper"

describe Webbed::Method do
  let(:method) { Webbed::Method::GET }

  describe "#initialize" do
    context "when not provided with enough options" do
      it "raises an error" do
        expect {
          Webbed::Method.new("INVALID", {})
        }.to raise_error(KeyError)
      end
    end

    context "when provided with enough options" do
      let(:method) { Webbed::Method.new("VALID", :safe => true, :idempotent => true, :allows_request_entity => true, :allows_response_entity => true) }

      it "sets the name" do
        method.name.should == "VALID"
      end

      it "sets the safety" do
        method.should be_safe
      end

      it "sets the idempotency" do
        method.should be_idempotent
      end

      it "sets the allowable entities" do
        method.should allow_entity(:request)
        method.should allow_entity(:response)
      end
    end
  end
end
