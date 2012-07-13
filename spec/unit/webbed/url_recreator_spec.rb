require "spec_helper"
require "addressable/uri"
require "webbed/url_recreator"

module Webbed
  describe URLRecreator do
    let(:target) { Addressable::URI.parse("http://google.com/") }
    let(:headers) { { "Host" => "google.com" } }
    let(:secure) { false }
    let(:request) { double(:request, target: target, headers: headers, secure?: secure) }
    subject(:recreator) { URLRecreator.new(request) }

    context "when the target has a host" do
      it "returns the target" do
        expect(recreator.recreate).to eq(target)
      end
    end

    context "when the target does not have a host" do
      let(:target) { Addressable::URI.parse("/") }

      context "when the Host header is present" do
        context "when the request is insecure" do
          it "recreates a URL using the target, Host header, and the HTTP scheme" do
            expect(recreator.recreate).to eq(Addressable::URI.parse("http://google.com/"))
          end
        end

        context "when the request is secure" do
          let(:secure) { true }
          
          it "recreates a URL using the target, Host header, and the HTTPS scheme" do
            expect(recreator.recreate).to eq(Addressable::URI.parse("https://google.com/"))
          end
        end
      end

      context "when the Host header is not present" do
        let(:headers) { {} }

        it "returns the target" do
          expect(recreator.recreate).to eq(target)
        end
      end
    end
  end
end
