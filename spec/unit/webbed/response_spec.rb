require "spec_helper"
require "webbed/response"
require "webbed/status_code"
require "webbed/http_version"

describe Webbed::Response do
  let(:response) { Webbed::Response.new(200, { "Content-Type" => "text/plain" }, ["test"]) }
  subject { response }

  describe "#initialize" do
    it "sets the status code" do
      subject.status_code.should == Webbed::StatusCode::OK
    end

    it "sets the headers" do
      subject.headers.should == { "Content-Type" => "text/plain" }
    end

    it "sets the entity body" do
      subject.entity_body.should == ["test"]
    end

    context "when not provided with an HTTP version" do
      it "uses HTTP/1.1" do
        subject.http_version.should == Webbed::HTTPVersion::ONE_POINT_ONE
      end
    end

    context "when provided with an HTTP version" do
      let(:response) { Webbed::Response.new(200, { "Content-Type" => "text/plain" }, [], http_version: "HTTP/1.0") }

      it "sets the HTTP version" do
        subject.http_version.should == Webbed::HTTPVersion::ONE_POINT_OH
      end
    end

    context "when not provided with a reason phrase" do
      it "uses the default reason phrase" do
        subject.reason_phrase.should == "OK"
      end
    end

    context "when provided with a reason phrase" do
      let(:response) { Webbed::Response.new(200, { "Content-Type" => "text/plain" }, [], reason_phrase: "Meh") }

      it "sets the reason phrase" do
        subject.reason_phrase.should == "Meh"
      end
    end
  end

  describe "#status_code" do
    subject { response.status_code }

    it "is an instance of Webbed::StatusCode" do
      subject.should be_a(Webbed::StatusCode)
    end
  end

  describe "#headers" do
    subject { response.headers }

    it "is an instance of Webbed::Headers" do
      subject.should be_a(Webbed::Headers)
    end
  end

  describe "#http_version" do
    subject { response.http_version }

    it "is an instance of Webbed::HTTPVersion" do
      subject.should be_a(Webbed::HTTPVersion)
    end
  end
end
