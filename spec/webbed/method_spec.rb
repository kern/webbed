require "spec_helper"

describe Webbed::Method do
  describe "#initialize" do
    context "when not provided with enough options" do
      it "raises an error" do
        expect { Carpenter(:invalid_method) }.to raise_error(KeyError)
      end
    end

    context "when provided with enough options" do
      let(:method) { Carpenter(:valid_method) }

      it "sets the name" do
        method.name.should == "VALID"
      end

      it "sets the safety" do
        method.should be_safe
      end

      it "sets the idempotency" do
        method.should be_idempotent
      end

      it "sets the allowable entities" do
        method.should allow_entity(:request)
        method.should allow_entity(:response)
      end
    end
  end

  describe "#==" do
    let(:method) { Carpenter(:valid_method) }

    it "returns true for methods that have the same name" do
      method.should == Carpenter(:valid_method_2)
    end

    it "returns false for methods that do not have the same name" do
      method.should_not == Carpenter(:get_method)
    end
  end

  describe ".register" do
    let(:method) { Carpenter(:valid_method) }
    after { Webbed::Method.unregister(method) }

    it "registers a method with its name for later lookup" do
      Webbed::Method.register(method)
      Webbed::Method.lookup("VALID").should == method
    end
  end

  describe ".unregister" do
    let(:method) { Carpenter(:valid_method) }
    before { Webbed::Method.register(method) }

    it "unregisters a method with its name" do
      Webbed::Method.unregister(method)
      Webbed::Method.lookup("VALID").should be_nil
    end
  end

  describe ".lookup" do
    let(:method) { Carpenter(:valid_method) }
    before { Webbed::Method.register(method) }
    after { Webbed::Method.unregister(method) }

    context "when a method with the provided name has been registered" do
      it "returns the registered method" do
        Webbed::Method.lookup("VALID").should == method
      end
    end

    context "when a method with the provided name has not been registered" do
      it "returns nil" do
        Webbed::Method.lookup("UNKNOWN").should be_nil
      end
    end
  end

  describe "OPTIONS" do
    let(:method) { Webbed::Method::OPTIONS }

    it "is registered" do
      Webbed::Method.lookup("OPTIONS").should == method
    end

    it "has the correct settings" do
      method.should be_safe
      method.should be_idempotent
      method.should_not allow_entity(:request)
      method.should allow_entity(:response)
    end
  end

  describe "GET" do
    let(:method) { Webbed::Method::GET }

    it "is registered" do
      Webbed::Method.lookup("GET").should == method
    end

    it "has the correct settings" do
      method.should be_safe
      method.should be_idempotent
      method.should_not allow_entity(:request)
      method.should allow_entity(:response)
    end
  end

  describe "HEAD" do
    let(:method) { Webbed::Method::HEAD }

    it "is registered" do
      Webbed::Method.lookup("HEAD").should == method
    end

    it "has the correct settings" do
      method.should be_safe
      method.should be_idempotent
      method.should_not allow_entity(:request)
      method.should_not allow_entity(:response)
    end
  end

  describe "POST" do
    let(:method) { Webbed::Method::POST }

    it "is registered" do
      Webbed::Method.lookup("POST").should == method
    end

    it "has the correct settings" do
      method.should_not be_safe
      method.should_not be_idempotent
      method.should allow_entity(:request)
      method.should allow_entity(:response)
    end
  end

  describe "PUT" do
    let(:method) { Webbed::Method::PUT }

    it "is registered" do
      Webbed::Method.lookup("PUT").should == method
    end

    it "has the correct settings" do
      method.should_not be_safe
      method.should be_idempotent
      method.should allow_entity(:request)
      method.should allow_entity(:response)
    end
  end

  describe "DELETE" do
    let(:method) { Webbed::Method::DELETE }

    it "is registered" do
      Webbed::Method.lookup("DELETE").should == method
    end

    it "has the correct settings" do
      method.should_not be_safe
      method.should be_idempotent
      method.should_not allow_entity(:request)
      method.should allow_entity(:response)
    end
  end

  describe "TRACE" do
    let(:method) { Webbed::Method::TRACE }

    it "is registered" do
      Webbed::Method.lookup("TRACE").should == method
    end

    it "has the correct settings" do
      method.should be_safe
      method.should be_idempotent
      method.should_not allow_entity(:request)
      method.should allow_entity(:response)
    end
  end

  describe "CONNECT" do
    let(:method) { Webbed::Method::CONNECT }

    it "is registered" do
      Webbed::Method.lookup("CONNECT").should == method
    end

    it "has the correct settings" do
      method.should_not be_safe
      method.should_not be_idempotent
      method.should allow_entity(:request)
      method.should allow_entity(:response)
    end
  end

  describe "PATCH" do
    let(:method) { Webbed::Method::PATCH }

    it "is registered" do
      Webbed::Method.lookup("PATCH").should == method
    end

    it "has the correct settings" do
      method.should_not be_safe
      method.should_not be_idempotent
      method.should allow_entity(:request)
      method.should allow_entity(:response)
    end
  end
end
