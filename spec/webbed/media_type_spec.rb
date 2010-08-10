require 'spec_helper'

describe Webbed::MediaType do
  context 'when created with just a MIME type' do
    subject { Webbed::MediaType.new 'application/json' }
    
    it 'should store the type' do
      subject.type.should == 'application'
    end
    
    it 'should store the subtype' do
      subject.subtype.should == 'json'
    end
    
    it 'should store the original MIME type' do
      subject.mime_type.should == 'application/json'
    end
    
    its(:parameters) { should be_empty }
  end
  
  context 'when created with both a MIME type and parameters' do
    subject { Webbed::MediaType.new 'text/html; foo=bar ; lol=rofl;test=test'}
    
    it 'should store the type' do
      subject.type.should == 'text'
    end
    
    it 'should store the subtype' do
      subject.subtype.should == 'html'
    end
    
    it 'should store the original MIME type' do
      subject.mime_type.should == 'text/html'
    end
    
    it 'should store the parameters' do
      subject.parameters['foo'].should == 'bar'
      subject.parameters['lol'].should == 'rofl'
      subject.parameters['test'].should == 'test'
    end
  end
  
  context 'when the MIME type is set' do
    subject { Webbed::MediaType.new 'image/png' }
    
    it 'should change the type' do
      lambda {
        subject.mime_type = 'text/html'
      }.should change(subject, :type).from('image').to('text')
    end
    
    it 'should store the subtype' do
      lambda {
        subject.mime_type = 'text/html'
      }.should change(subject, :subtype).from('png').to('html')
    end
    
    it 'should store the original MIME type' do
      lambda {
        subject.mime_type = 'text/html'
      }.should change(subject, :mime_type).from('image/png').to('text/html')
    end
  end
  
  context 'when the type is set' do
    subject { Webbed::MediaType.new 'application/xml' }
    
    it 'should change the type' do
      lambda {
        subject.type = 'image'
      }.should change(subject, :type).from('application').to('image')
    end
    
    it 'should change the MIME type' do
      lambda {
        subject.type = 'image'
      }.should change(subject, :mime_type).from('application/xml').to('image/xml')
    end
  end
  
  context 'when the subtype is set' do
    subject { Webbed::MediaType.new 'application/xml' }
    
    it 'should change the subtype' do
      lambda {
        subject.subtype = 'json'
      }.should change(subject, :subtype).from('xml').to('json')
    end
    
    it 'should change the MIME type' do
      lambda {
        subject.subtype = 'json'
      }.should change(subject, :mime_type).from('application/xml').to('application/json')
    end
  end
  
  context 'when the parameters are set' do
    subject { Webbed::MediaType.new 'application/json; foo=bar' }
    
    it 'should change the parameters' do
      lambda {
        subject.parameters = {'test' => 'lol'}
      }.should change(subject, :parameters).from('foo' => 'bar').to('test' => 'lol')
    end
  end
  
  describe '#to_s' do
    before { @media_type = Webbed::MediaType.new 'application/json' }
    subject { @media_type.to_s }
    
    context 'when there is only a MIME type' do
      it 'should be just the MIME type' do
        should == 'application/json'
      end
    end
    
    context 'when there is one parameter' do
      before { @media_type.parameters = {'foo' => 'bar'} }
      
      it 'should be the concatenation of the MIME type the one parameter' do
        should == 'application/json; foo=bar'
      end
    end
    
    context 'when there are multiple parameters' do
      before { @media_type.parameters = {'foo' => 'bar', 'test' => 'test'} }
      
      it 'should be the concatenation of the MIME type and all parameters' do
        should == 'application/json; foo=bar; test=test'
      end
    end
  end
  
  describe 'vendor specific MIME types' do
    context 'when the subtype starts with vnd.' do
      subject { Webbed::MediaType.new 'application/vnd.lol+xml' }
      it { should be_vendor_specific }
    end
    
    context 'when the subtype does not start with a vnd.' do
      subject { Webbed::MediaType.new 'application/xml' }
      it { should_not be_vendor_specific }
    end
  end
  
  describe 'MIME type suffixes' do
    context 'when the MIME type has a suffix' do
      subject { Webbed::MediaType.new 'application/atom+xml' }
      
      it 'should be the correct suffix' do
        subject.suffix.should == 'xml'
      end
      
      it 'should be able to be interpreted with the MIME type' do
        subject.interpretable_as.should include('application/atom+xml')
      end
      
      it 'should be able to be interpreted with the suffix subtype' do
        subject.interpretable_as.should include('application/xml')
      end
    end
    
    context 'when the MIME type does not have a suffix' do
      subject { Webbed::MediaType.new 'application/json' }
      
      it 'should not have a suffix' do
        subject.suffix.should be_nil
      end
      
      it 'should only be able to be interpreted with the MIME type' do
        subject.interpretable_as.should == ['application/json']
      end
    end
  end
end