require "spec_helper"

describe Webbed::HTTPVersion do
  describe "#initialize" do
    context "when given a valid HTTP Version" do
      let(:version) { Carpenter(:http_version_1_1) }

      it "sets the major version number" do
        version.major.should == 1
      end

      it "sets the minor version number" do
        version.minor.should == 1
      end
    end

    context "when given an invalid HTTP Version" do
      let(:version) { Carpenter(:invalid_http_version) }

      it "raises a parsing error" do
        expect { version }.to raise_error(Webbed::ParseError)
      end
    end
  end

  describe "#to_s" do
    let(:version) { Carpenter(:http_version_1_1) }

    it "returns the string representation of the HTTP Version" do
      version.to_s.should == "HTTP/1.1"
    end
  end

  describe "#to_a" do
    let(:version) { Carpenter(:http_version_1_1) }

    it "returns the array representation of the HTTP Version" do
      version.to_a.should == [1, 1]
    end
  end

  describe "#<=>" do
    let(:version_1_1) { Carpenter(:http_version_1_1) }
    let(:version_1_0) { Carpenter(:http_version_1_0) }

    it "determines if two versions are equal" do
      version_1_1.should == version_1_1
      version_1_1.should_not be < version_1_1
      version_1_1.should_not be > version_1_1
    end

    it "determines if two versions are inequal" do
      version_1_0.should_not == version_1_1
      version_1_0.should be < version_1_1
      version_1_1.should be > version_1_0
    end
  end

  describe "HTTP/1.1" do
    let(:version) { Webbed::HTTPVersion::ONE_POINT_ONE }

    it "has a major version of 1" do
      version.major.should == 1
    end

    it "has a minor version of 1" do
      version.minor.should == 1
    end
  end

  describe "HTTP/1.0" do
    let(:version) { Webbed::HTTPVersion::ONE_POINT_OH }

    it "has a major version of 1" do
      version.major.should == 1
    end

    it "has a minor version of 0" do
      version.minor.should == 0
    end
  end
end
