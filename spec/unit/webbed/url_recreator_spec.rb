require "spec_helper"
require "addressable/uri"
require "webbed/url_recreator"

module Webbed
  describe URLRecreator do
    let(:request_uri) { Addressable::URI.parse("http://google.com/") }
    let(:headers) { { "Host" => "google.com" } }
    let(:secure) { false }
    let(:request) { double(:request, request_uri: request_uri, headers: headers, secure?: secure) }
    let(:recreator) { URLRecreator.new(request) }

    context "when the request URI has a host" do
      it "returns the request URI" do
        recreator.recreate.should == request_uri
      end
    end

    context "when the request URI does not have a host" do
      let(:request_uri) { Addressable::URI.parse("/") }

      context "when the Host header is present" do
        context "when the request is insecure" do
          it "recreates a URL using the request URI, Host header, and the HTTP scheme" do
            recreator.recreate.should == Addressable::URI.parse("http://google.com/")
          end
        end

        context "when the request is secure" do
          let(:secure) { true }
          
          it "recreates a URL using the request URI, Host header, and the HTTPS scheme" do
            recreator.recreate.should == Addressable::URI.parse("https://google.com/")
          end
        end
      end

      context "when the Host header is not present" do
        let(:headers) { {} }

        it "returns the request URI" do
          recreator.recreate.should == request_uri
        end
      end
    end
  end
end
