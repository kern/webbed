require "spec_helper"
require "webbed/response"
require "webbed/status_code"
require "webbed/http_version"

module Webbed
  describe Response do
    let(:status_code) { 200 }
    let(:headers) { { "Content-Type" => "text/plain" } }
    let(:entity_body) { ["test"] }
    let(:options) { {} }
    subject { Response.new(status_code, headers, entity_body, options) }

    describe "#initialize" do
      it "sets the status code" do
        subject.status_code.should == StatusCode::OK
      end

      it "sets the headers" do
        subject.headers.should == { "Content-Type" => "text/plain" }
      end

      it "sets the entity body" do
        subject.entity_body.should == ["test"]
      end

      context "when not provided with an HTTP version" do
        it "uses HTTP/1.1" do
          subject.http_version.should == HTTPVersion::ONE_POINT_ONE
        end
      end

      context "when provided with an HTTP version" do
        let(:options) { { http_version: "HTTP/1.0" } }

        it "sets the HTTP version" do
          subject.http_version.should == HTTPVersion::ONE_POINT_OH
        end
      end

      context "when not provided with a reason phrase" do
        it "uses the default reason phrase" do
          subject.reason_phrase.should == "OK"
        end
      end

      context "when provided with a reason phrase" do
        let(:options) { { reason_phrase: "Meh" } }

        it "sets the reason phrase" do
          subject.reason_phrase.should == "Meh"
        end
      end
    end
  end
end
