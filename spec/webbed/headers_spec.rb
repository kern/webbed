require "spec_helper"

# TODO: Add more examples to this. Since it was stolen from Rack, I'm pretty
# darn sure that it works correctly. Still, as a matter of principle, it should
# have all the necessary tests to make sure it works correctly when it changes.
# But yeah, very low priority at the moment.
describe Webbed::Headers do
  describe "#initialize" do
    context "without headers" do
      let(:headers) { Webbed::Headers.new }

      it "is empty" do
        headers.should be_empty
      end
    end

    context "with headers" do
      let(:headers) { Webbed::Headers.new("Host" => "foo.com") }

      it "is not empty" do
        headers.should_not be_empty
      end

      it "stores the headers case-insensitively" do
        headers["Host"].should == "foo.com"
        headers["host"].should == "foo.com"
        headers["HOST"].should == "foo.com"
      end
    end
  end

  context "#to_s" do
    let(:headers) do
      Webbed::Headers.new(
        "Content-Type" => "application/json",
        "Host" => "foo.com"
      )
    end

    it "formats the headers according to RFC 2616" do
      headers.to_s.should == "Content-Type: application/json\r\nHost: foo.com\r\n"
    end
  end
end
