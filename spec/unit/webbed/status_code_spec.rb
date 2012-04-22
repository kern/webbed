require "spec_helper"
require "webbed/status_code"

describe Webbed::StatusCode do
  let(:continue) { Webbed::StatusCode.new(100, "Continue") }
  let(:ok) { Webbed::StatusCode.new(200, "OK") }
  let(:found) { Webbed::StatusCode.new(300, "Found") }
  let(:not_found) { Webbed::StatusCode.new(404, "Not Found") }
  let(:bad_gateway) { Webbed::StatusCode.new(502, "Bad Gateway") }
  let(:unknown) { Webbed::StatusCode.new(600, "Unknown") }

  describe "#initialize" do
    it "sets the integer representation" do
      ok.to_i.should == 200
    end

    it "sets the default reason phrase" do
      ok.default_reason_phrase.should == "OK"
    end
  end

  describe "#informational?" do
    context "when the status code is in the 100s" do
      it "returns true" do
        continue.should be_informational
      end
    end

    context "when the status code is not in the 100s" do
      it "returns false" do
        ok.should_not be_informational
      end
    end
  end

  describe "#successful?" do
    context "when the status code is in the 200s" do
      it "returns true" do
        ok.should be_successful
      end
    end

    context "when the status code is not in the 200s" do
      it "returns false" do
        continue.should_not be_successful
      end
    end
  end

  describe "#redirection?" do
    context "when the status code is in the 300s" do
      it "returns true" do
        found.should be_a_redirection
      end
    end

    context "when the status code is not in the 300s" do
      it "returns false" do
        continue.should_not be_a_redirection
      end
    end
  end

  describe "#client_error?" do
    context "when the status code is in the 400s" do
      it "returns true" do
        not_found.should be_a_client_error
      end
    end

    context "when the status code is not in the 400s" do
      it "returns false" do
        continue.should_not be_a_client_error
      end
    end
  end

  describe "#server_error?" do
    context "when the status code is in the 500s" do
      it "returns true" do
        bad_gateway.should be_a_server_error
      end
    end

    context "when the status code is not in the 500s" do
      it "returns false" do
        continue.should_not be_a_server_error
      end
    end
  end

  describe "#error?" do
    context "when the status code is in the 400s or 500s" do
      it "returns true" do
        not_found.should be_an_error
        bad_gateway.should be_an_error
      end
    end

    context "when the status code is not in the 500s" do
      it "returns false" do
        continue.should_not be_an_error
      end
    end
  end

  describe "#unknown?" do
    context "when the status code is in the defined status code range" do
      it "returns false" do
        continue.should_not be_unknown
        ok.should_not be_unknown
        found.should_not be_unknown
        not_found.should_not be_unknown
        bad_gateway.should_not be_unknown
      end
    end

    context "when the status code is not in the defined status code range" do
      it "returns true" do
        unknown.should be_unknown
      end
    end
  end

  describe "#lookup_key" do
    it "returns the integer representation" do
      ok.lookup_key.should == 200
    end
  end

  specify "equality" do
    ok.should == Webbed::StatusCode.new(200, "OK")
    ok.should > Webbed::StatusCode.new(200, "Awesome")
    ok.should < Webbed::StatusCode.new(200, "Somewhat Okay")
    ok.should > continue
    ok.should < found
  end
end
