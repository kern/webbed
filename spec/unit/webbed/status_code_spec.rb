require "spec_helper"
require "webbed/status_code"

module Webbed
  describe StatusCode do
    let(:integer) { 200 }
    subject(:status_code) { StatusCode.new(integer, "OK") }

    it_behaves_like "a registry" do
      subject(:registry) { StatusCode }
      let(:lookup_key) { 200 }
      let(:obj1) { double(:status_code_1, to_i: 200) }
      let(:obj2) { double(:status_code_2, to_i: 200) }
    end

    it "can be converted to an integer" do
      expect(status_code.to_i).to eq(200)
    end

    it "has a default reason phrase" do
      expect(status_code.default_reason_phrase).to eq("OK")
    end

    context "when the status code is in the 100s" do
      let(:integer) { 137 }

      it "is informational" do
        expect(status_code).to be_informational
      end

      it "is not any of the other types of status codes" do
        expect(status_code).not_to be_successful
        expect(status_code).not_to be_a_redirection
        expect(status_code).not_to be_a_client_error
        expect(status_code).not_to be_a_server_error
        expect(status_code).not_to be_an_error
        expect(status_code).not_to be_unknown
      end
    end

    context "when the status code is in the 200s" do
      let(:integer) { 277 }

      it "is successful" do
        expect(status_code).to be_successful
      end
      
      it "is not any of the other types of status codes" do
        expect(status_code).not_to be_informational
        expect(status_code).not_to be_a_redirection
        expect(status_code).not_to be_a_client_error
        expect(status_code).not_to be_a_server_error
        expect(status_code).not_to be_an_error
        expect(status_code).not_to be_unknown
      end
    end

    context "when the status code is in the 300s" do
      let(:integer) { 324 }

      it "is a redirection" do
        expect(status_code).to be_a_redirection
      end
      
      it "is not any of the other types of status codes" do
        expect(status_code).not_to be_informational
        expect(status_code).not_to be_successful
        expect(status_code).not_to be_a_client_error
        expect(status_code).not_to be_a_server_error
        expect(status_code).not_to be_an_error
        expect(status_code).not_to be_unknown
      end
    end

    context "when the status code is in the 400s" do
      let(:integer) { 444 }

      it "is a client error" do
        expect(status_code).to be_a_client_error
      end

      it "is an error" do
        expect(status_code).to be_an_error
      end

      it "is not any of the other types of status codes" do
        expect(status_code).not_to be_informational
        expect(status_code).not_to be_successful
        expect(status_code).not_to be_a_redirection
        expect(status_code).not_to be_a_server_error
        expect(status_code).not_to be_unknown
      end
    end

    context "when the status code is in the 500s" do
      let(:integer) { 530 }

      it "is a server error" do
        expect(status_code).to be_a_server_error
      end

      it "is an error" do
        expect(status_code).to be_an_error
      end

      it "is not any of the other types of status codes" do
        expect(status_code).not_to be_informational
        expect(status_code).not_to be_successful
        expect(status_code).not_to be_a_redirection
        expect(status_code).not_to be_a_client_error
        expect(status_code).not_to be_unknown
      end
    end

    context "when the status code is not in the defined status code range" do
      let(:integer) { 606 }

      it "is unknown" do
        expect(status_code).to be_unknown
      end

      it "is not any of the other types of status codes" do
        expect(status_code).not_to be_informational
        expect(status_code).not_to be_successful
        expect(status_code).not_to be_a_redirection
        expect(status_code).not_to be_a_client_error
        expect(status_code).not_to be_a_server_error
        expect(status_code).not_to be_an_error
      end
    end

    it "can be compared to other status codes based on its integer representation and default reason phrase" do
      expect(status_code).to eq(StatusCode.new(200, "OK"))
      expect(status_code).to be > StatusCode.new(200, "Awesome")
      expect(status_code).to be < StatusCode.new(200, "Somewhat Okay")
      expect(status_code).to be > StatusCode.new(100, "Continue")
      expect(status_code).to be < StatusCode.new(302, "Found")
    end
  end
end
