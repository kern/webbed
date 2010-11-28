require 'spec_helper'

describe Webbed::MediaType do
  subject { media_type }
  let(:no_params) { Webbed::MediaType.new 'text/html' }
  let(:media_type) { Webbed::MediaType.new 'text/html; foo=bar; lol=rofl; test=test' }
  
  context "when created with just a MIME type" do
    let(:media_type) { Webbed::MediaType.new 'application/json' }
    
    it "should set #type" do
      media_type.type.should == 'application'
    end
    
    it "should set #subtype" do
      media_type.subtype.should == 'json'
    end
    
    it "should set #mime_type" do
      media_type.mime_type.should == 'application/json'
    end
    
    its(:parameters) { should be_empty }
  end
  
  context "when created with both a MIME type and parameters" do
    it "should set #type" do
      media_type.type.should == 'text'
    end
    
    it "should set #subtype" do
      media_type.subtype.should == 'html'
    end
    
    it "should set #mime_type" do
      media_type.mime_type.should == 'text/html'
    end
    
    it "should set #parameters" do
      media_type.parameters['foo'].should == 'bar'
      media_type.parameters['lol'].should == 'rofl'
      media_type.parameters['test'].should == 'test'
    end
  end
  
  context "when created with parameters that have random spaces" do
    let(:media_type) { Webbed::MediaType.new 'text/html;   foo=bar ; lol=rofl' }
    
    it "should set #parameters to the trimmed parameters" do
      media_type.parameters['foo'].should == 'bar'
      media_type.parameters['lol'].should == 'rofl'
    end
  end
  
  describe "#mime_type" do
    it "should change #type" do
      lambda {
        media_type.mime_type = 'application/json'
      }.should change(media_type, :type).from('text').to('application')
    end
    
    it "should store the subtype" do
      lambda {
        media_type.mime_type = 'application/json'
      }.should change(media_type, :subtype).from('html').to('json')
    end
    
    it "should store the original MIME type" do
      lambda {
        media_type.mime_type = 'application/json'
      }.should change(media_type, :mime_type).from('text/html').to('application/json')
    end
  end
  
  describe "#set=" do
    it "should change #type" do
      lambda {
        media_type.type = 'image'
      }.should change(media_type, :type).from('text').to('image')
    end
    
    it "should change #mime_type" do
      lambda {
        media_type.type = 'image'
      }.should change(media_type, :mime_type).from('text/html').to('image/html')
    end
  end
  
  describe "#subtype=" do
    it "should change #subtype" do
      lambda {
        media_type.subtype = 'json'
      }.should change(media_type, :subtype).from('html').to('json')
    end
    
    it "should change #mime_type" do
      lambda {
        media_type.subtype = 'json'
      }.should change(media_type, :mime_type).from('text/html').to('text/json')
    end
  end
  
  describe "#parameters=" do
    it "should change the parameters" do
      lambda {
        media_type.parameters = {'test' => 'lol'}
      }.should change(media_type, :parameters).to('test' => 'lol')
    end
  end
  
  describe "#to_s" do
    context "when there is only a MIME type" do
      it "should be #mime_type" do
        no_params.to_s.should == 'text/html'
      end
    end
    
    context "when there are parameters" do
      it "should be the concatenation of the MIME type and all parameters" do
        media_type.to_s.should == 'text/html; foo=bar; lol=rofl; test=test'
      end
    end
  end
  
  describe "#vendor_specific?" do
    context "when #subtype starts with vnd." do
      let(:media_type) { Webbed::MediaType.new 'application/vnd.lol+xml' }
      it { should be_vendor_specific }
    end
    
    context "when #subtype does not start with a vnd." do
      it { should_not be_vendor_specific }
    end
  end
  
  describe "#suffix" do
    context "when #mime_type has a suffix" do
      let(:media_type) { Webbed::MediaType.new 'application/atom+xml' }
      
      it "should be set" do
        media_type.suffix.should == 'xml'
      end
      
      it "should be interpretable as #mime_type" do
        media_type.interpretable_as.should include('application/atom+xml')
      end
      
      it "should be able interpretable the suffix MIME type" do
        media_type.interpretable_as.should include('application/xml')
      end
    end
    
    context "when the MIME type does not have a suffix" do
      it "should not be set" do
        media_type.suffix.should be_nil
      end
      
      it "should only be able to be interpretable as the #mime_type" do
        media_type.interpretable_as.should == ['text/html']
      end
    end
  end
end