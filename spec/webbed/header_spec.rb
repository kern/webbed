require 'spec_helper'

describe Webbed::Header do
  before do
    @header = Webbed::Header.new('X-Foo', ' Bar ')
  end
  
  subject { @header }
  
  describe 'field name' do
    subject { @header.field_name }
    
    it 'return the field name' do
      subject.should == 'X-Foo'
    end
    
    it 'should be able to be set' do
      @header.field_name = 'X-Bar'
      subject.should == 'X-Bar'
    end
  end
  
  describe 'field value' do
    subject { @header.field_value }
     
    it 'shoud return the raw field value' do
      subject.should == ' Bar '
    end
    
    it 'should be able to be set' do
      @header.field_value = ' Foo '
      subject.should == ' Foo '
    end
    
    it 'should be set when the field value is set' do
      @header.field_content = 'Foo'
      @header.field_value.should == 'Foo'
    end
  end
  
  describe 'field content' do
    subject { @header.field_content }
    
    it 'should return the field content after trimming' do
      subject.should == 'Bar'
    end
    
    it 'should be able to be set' do
      @header.field_content = 'Foo'
      subject.should == 'Foo'
    end
    
    it 'should be set when the field value is set' do
      @header.field_value = ' Foo '
      subject.should == 'Foo'
    end
  end
end