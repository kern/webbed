require "spec_helper"
require "webbed/status_code"

module Webbed
  describe StatusCode do
    let(:integer) { 200 }
    subject { StatusCode.new(integer, "OK") }

    it "can be converted to an integer" do
      subject.to_i.should == 200
    end

    it "has a default reason phrase" do
      subject.default_reason_phrase.should == "OK"
    end

    context "when the status code is in the 100s" do
      let(:integer) { 137 }

      it "is informational" do
        subject.should be_informational
      end

      it "is not any of the other types of status codes" do
        subject.should_not be_successful
        subject.should_not be_a_redirection
        subject.should_not be_a_client_error
        subject.should_not be_a_server_error
        subject.should_not be_an_error
        subject.should_not be_unknown
      end
    end

    context "when the status code is in the 200s" do
      let(:integer) { 277 }

      it "is successful" do
        subject.should be_successful
      end
      
      it "is not any of the other types of status codes" do
        subject.should_not be_informational
        subject.should_not be_a_redirection
        subject.should_not be_a_client_error
        subject.should_not be_a_server_error
        subject.should_not be_an_error
        subject.should_not be_unknown
      end
    end

    context "when the status code is in the 300s" do
      let(:integer) { 324 }

      it "is a redirection" do
        subject.should be_a_redirection
      end
      
      it "is not any of the other types of status codes" do
        subject.should_not be_informational
        subject.should_not be_successful
        subject.should_not be_a_client_error
        subject.should_not be_a_server_error
        subject.should_not be_an_error
        subject.should_not be_unknown
      end
    end

    context "when the status code is in the 400s" do
      let(:integer) { 444 }

      it "is a client error" do
        subject.should be_a_client_error
      end

      it "is an error" do
        subject.should be_an_error
      end

      it "is not any of the other types of status codes" do
        subject.should_not be_informational
        subject.should_not be_successful
        subject.should_not be_a_redirection
        subject.should_not be_a_server_error
        subject.should_not be_unknown
      end
    end

    context "when the status code is in the 500s" do
      let(:integer) { 530 }

      it "is a server error" do
        subject.should be_a_server_error
      end

      it "is an error" do
        subject.should be_an_error
      end

      it "is not any of the other types of status codes" do
        subject.should_not be_informational
        subject.should_not be_successful
        subject.should_not be_a_redirection
        subject.should_not be_a_client_error
        subject.should_not be_unknown
      end
    end

    context "when the status code is not in the defined status code range" do
      let(:integer) { 606 }

      it "is unknown" do
        subject.should be_unknown
      end

      it "is not any of the other types of status codes" do
        subject.should_not be_informational
        subject.should_not be_successful
        subject.should_not be_a_redirection
        subject.should_not be_a_client_error
        subject.should_not be_a_server_error
        subject.should_not be_an_error
      end
    end

    it "uses its integer representation as its lookup key" do
      subject.lookup_key.should == 200
    end

    it "can be compared to other status codes based on its integer representation and default reason phrase" do
      subject.should == StatusCode.new(200, "OK")
      subject.should > StatusCode.new(200, "Awesome")
      subject.should < StatusCode.new(200, "Somewhat Okay")
      subject.should > StatusCode.new(100, "Continue")
      subject.should < StatusCode.new(302, "Found")
    end
  end
end
