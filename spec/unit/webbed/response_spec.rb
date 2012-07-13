require "spec_helper"
require "webbed/response"
require "webbed/status_code"
require "webbed/http_version"

module Webbed
  describe Response do
    let(:status_code) { double(:status_code, default_reason_phrase: "OK") }
    let(:headers) { double(:headers) }
    let(:body) { double(:body) }
    let(:http_version) { double(:http_version) }
    let(:conversions) { double(:conversions) }
    let(:options) { {} }
    subject(:response) { Response.new(200, {}, body, { conversions: conversions }.merge(options)) }

    before do
      conversions.stub(:StatusCode).with(200) { status_code }
      conversions.stub(:Headers).with({}) { headers }
      conversions.stub(:HTTPVersion).with(HTTPVersion::ONE_POINT_ONE) { HTTPVersion::ONE_POINT_ONE }
      conversions.stub(:HTTPVersion).with("HTTP/1.0") { http_version }
    end

    it "converts the status code to an instance of Webbed::StatusCode" do
      expect(response.status_code).to eq(status_code)
    end

    it "converts the headers to an instance of Webbed::Headers" do
      expect(response.headers).to eq(headers)
    end

    it "has a body" do
      expect(response.body).to eq(body)
    end

    context "when not provided with an HTTP version" do
      it "uses HTTP/1.1" do
        expect(response.http_version).to eq(HTTPVersion::ONE_POINT_ONE)
      end
    end    

    context "when provided with an HTTP version" do
      let(:options) { { http_version: "HTTP/1.0" } }

      it "uses that HTTP version" do
        expect(response.http_version).to eq(http_version)
      end
    end

    context "when not provided with a reason phrase" do
      it "uses the default reason phrase" do
        expect(response.reason_phrase).to eq("OK")
      end
    end

    context "when provided with a reason phrase" do
      let(:options) { { reason_phrase: "LOL" } }

      it "uses that reason phrase" do
        expect(response.reason_phrase).to eq("LOL")
      end
    end
  end
end
