require "spec_helper"
require "webbed/method"
require "webbed/unknown_method"

describe Webbed::Method do
  let(:method) { Webbed::Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true) }
  subject { method }

  describe "#initialize" do
    it "sets the string representation of the method" do
      method.to_s.should == "GET"
    end

    it "sets whether or not the method is safe" do
      method.should be_safe
    end

    it "sets whether or not the method is idempotent" do
      method.should be_idempotent
    end

    it "sets whether or not the method allows a request entity" do
      method.should_not allow_a_request_entity
    end

    it "sets whether or not the method allows a response entity" do
      method.should allow_a_response_entity
    end
  end

  specify "equality" do
    method.should == Webbed::Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true)
    method.should_not == Webbed::Method.new("HEAD", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: true)
    method.should_not == Webbed::Method.new("GET", safe: false, idempotent: true, allows_request_entity: false, allows_response_entity: true)
    method.should_not == Webbed::Method.new("GET", safe: true, idempotent: false, allows_request_entity: false, allows_response_entity: true)
    method.should_not == Webbed::Method.new("GET", safe: true, idempotent: true, allows_request_entity: true, allows_response_entity: true)
    method.should_not == Webbed::Method.new("GET", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: false)
  end

  describe "registration and lookup" do
    let(:registered) { Webbed::Method.new("REGISTERED", safe: true, idempotent: true, allows_request_entity: false, allows_response_entity: false) }
    
    before do
      Webbed::Method.register(registered)
    end

    after do
      Webbed::Method.unregister(registered)
    end

    context "when looking up a registered method" do
      it "returns the registered method" do
        Webbed::Method.look_up("REGISTERED").should == registered
      end
    end

    context "when looking up an unregistered method" do
      it "raises an error" do
        expect {
          Webbed::Method.look_up("UNREGISTERED")
        }.to raise_error(Webbed::UnknownMethod)
      end
    end

    context "when registering an already registered method" do
      let(:new_registered) { Webbed::Method.new("REGISTERED", safe: false, idempotent: true, allows_request_entity: false, allows_response_entity: false) }

      before do
        Webbed::Method.register(new_registered)
      end

      after do
        Webbed::Method.unregister(new_registered)
      end

      it "overwrites the previous method" do
        Webbed::Method.look_up("REGISTERED").should == new_registered
      end
    end
  end
  
  specify "OPTIONS" do
    method = Webbed::Method::OPTIONS
    
    method.to_s.should == "OPTIONS"
    method.should be_safe
    method.should be_idempotent
    method.should_not allow_a_request_entity
    method.should allow_a_response_entity
  end
  
  specify "GET" do
    method = Webbed::Method::GET
    
    method.to_s.should == "GET"
    method.should be_safe
    method.should be_idempotent
    method.should_not allow_a_request_entity
    method.should allow_a_response_entity
  end
  
  specify "HEAD" do
    method = Webbed::Method::HEAD
    
    method.to_s.should == "HEAD"
    method.should be_safe
    method.should be_idempotent
    method.should_not allow_a_request_entity
    method.should_not allow_a_response_entity
  end
  
  specify "POST" do
    method = Webbed::Method::POST
    
    method.to_s.should == "POST"
    method.should_not be_safe
    method.should_not be_idempotent
    method.should allow_a_request_entity
    method.should allow_a_response_entity
  end
  
  specify "PUT" do
    method = Webbed::Method::PUT
    
    method.to_s.should == "PUT"
    method.should_not be_safe
    method.should be_idempotent
    method.should allow_a_request_entity
    method.should allow_a_response_entity
  end
  
  specify "DELETE" do
    method = Webbed::Method::DELETE
    
    method.to_s.should == "DELETE"
    method.should_not be_safe
    method.should be_idempotent
    method.should_not allow_a_request_entity
    method.should allow_a_response_entity
  end
  
  specify "TRACE" do
    method = Webbed::Method::TRACE
    
    method.to_s.should == "TRACE"
    method.should be_safe
    method.should be_idempotent
    method.should_not allow_a_request_entity
    method.should allow_a_response_entity
  end
  
  specify "CONNECT" do
    method = Webbed::Method::CONNECT
    
    method.to_s.should == "CONNECT"
    method.should_not be_safe
    method.should_not be_idempotent
    method.should allow_a_request_entity
    method.should allow_a_response_entity
  end
  
  specify "PATCH" do
    method = Webbed::Method::PATCH
    
    method.to_s.should == "PATCH"
    method.should_not be_safe
    method.should_not be_idempotent
    method.should allow_a_request_entity
    method.should allow_a_response_entity
  end
end
