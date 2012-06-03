require "spec_helper"
require "webbed/status_code"

module Webbed
  describe StatusCode do
    let(:integer) { 200 }
    let(:status_code) { StatusCode.new(integer, "OK") }

    it "can be converted to an integer" do
      status_code.to_i.should == 200
    end

    it "has a default reason phrase" do
      status_code.default_reason_phrase.should == "OK"
    end

    context "when the status code is in the 100s" do
      let(:integer) { 137 }

      it "is informational" do
        status_code.should be_informational
      end

      it "is not any of the other types of status codes" do
        status_code.should_not be_successful
        status_code.should_not be_a_redirection
        status_code.should_not be_a_client_error
        status_code.should_not be_a_server_error
        status_code.should_not be_an_error
        status_code.should_not be_unknown
      end
    end

    context "when the status code is in the 200s" do
      let(:integer) { 277 }

      it "is successful" do
        status_code.should be_successful
      end
      
      it "is not any of the other types of status codes" do
        status_code.should_not be_informational
        status_code.should_not be_a_redirection
        status_code.should_not be_a_client_error
        status_code.should_not be_a_server_error
        status_code.should_not be_an_error
        status_code.should_not be_unknown
      end
    end

    context "when the status code is in the 300s" do
      let(:integer) { 324 }

      it "is a redirection" do
        status_code.should be_a_redirection
      end
      
      it "is not any of the other types of status codes" do
        status_code.should_not be_informational
        status_code.should_not be_successful
        status_code.should_not be_a_client_error
        status_code.should_not be_a_server_error
        status_code.should_not be_an_error
        status_code.should_not be_unknown
      end
    end

    context "when the status code is in the 400s" do
      let(:integer) { 444 }

      it "is a client error" do
        status_code.should be_a_client_error
      end

      it "is an error" do
        status_code.should be_an_error
      end

      it "is not any of the other types of status codes" do
        status_code.should_not be_informational
        status_code.should_not be_successful
        status_code.should_not be_a_redirection
        status_code.should_not be_a_server_error
        status_code.should_not be_unknown
      end
    end

    context "when the status code is in the 500s" do
      let(:integer) { 530 }

      it "is a server error" do
        status_code.should be_a_server_error
      end

      it "is an error" do
        status_code.should be_an_error
      end

      it "is not any of the other types of status codes" do
        status_code.should_not be_informational
        status_code.should_not be_successful
        status_code.should_not be_a_redirection
        status_code.should_not be_a_client_error
        status_code.should_not be_unknown
      end
    end

    context "when the status code is not in the defined status code range" do
      let(:integer) { 606 }

      it "is unknown" do
        status_code.should be_unknown
      end

      it "is not any of the other types of status codes" do
        status_code.should_not be_informational
        status_code.should_not be_successful
        status_code.should_not be_a_redirection
        status_code.should_not be_a_client_error
        status_code.should_not be_a_server_error
        status_code.should_not be_an_error
      end
    end

    it "uses its integer representation as its lookup key" do
      status_code.lookup_key.should == 200
    end

    it "can be compared to other status codes based on its integer representation and default reason phrase" do
      status_code.should == StatusCode.new(200, "OK")
      status_code.should > StatusCode.new(200, "Awesome")
      status_code.should < StatusCode.new(200, "Somewhat Okay")
      status_code.should > StatusCode.new(100, "Continue")
      status_code.should < StatusCode.new(302, "Found")
    end
  end
end
