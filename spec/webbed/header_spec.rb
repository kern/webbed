require 'spec_helper'

describe Webbed::Header, 'field name' do
  before do
    @header = Webbed::Header.new('X-Foo', 'Bar')
  end
  
  subject { @header.field_name }
  
  it 'should be stored' do
    should == 'X-Foo'
  end
  
  it 'should be settable' do
    @header.field_name = 'X-Bar'
    subject.should == 'X-Bar'
  end
end

describe Webbed::Header, 'field value' do
  before do
    @header = Webbed::Header.new('X-Foo', ' Bar ')
  end
  
  subject { @header.field_value }
  
  it 'shoud be stored' do
    should == ' Bar '
  end
  
  it 'should be able to be set' do
    @header.field_value = ' Foo '
    subject.should == ' Foo '
  end
  
  it 'should be set when the field value is set' do
    @header.field_content = 'Foo'
    subject.should == 'Foo'
  end
end

describe Webbed::Header, 'field value' do
  before do
    @header = Webbed::Header.new('X-Foo', ' Bar ')
  end
  
  subject { @header.field_content }
  
  it 'should be stored after trimming the field value' do
    should == 'Bar'
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

describe Webbed::Header, '#to_s' do
  before do
    @header = Webbed::Header.new('X-Foo', 'Bar')
  end
  
  subject { @header }
  
  it 'should use the field name to create the string' do
    subject.should_receive(:field_name)
    subject.to_s
  end
  
  it 'should use the field content to create the string' do
    subject.should_receive(:field_content)
    subject.to_s
  end
  
  it 'should add the necessary spacing' do
    subject.to_s.should == 'X-Foo: Bar'
  end
end