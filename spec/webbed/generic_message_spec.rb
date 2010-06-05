require 'spec_helper'

describe Webbed::GenericMessage, 'start line' do
  before do
    @klass = Class.new { include Webbed::GenericMessage }
    @generic_message = @klass.new
  end
  
  subject { @generic_message.start_line }
  
  it { should == "Invalid Start Line\r\n" }
end

describe Webbed::GenericMessage, 'headers' do
  before do
    @klass = Class.new { include Webbed::GenericMessage }
    @generic_message = @klass.new
  end
  
  subject { @generic_message.headers }
  
  it { should be_an_instance_of(Webbed::Headers) }
  
  context 'upon creation' do
    it { should be_empty }
  end
end

describe Webbed::GenericMessage, 'entity body' do
  before do
    @klass = Class.new { include Webbed::GenericMessage }
    @generic_message = @klass.new
  end
  
  subject { @generic_message.entity_body }
  
  context 'upon creation' do
    it { should be_empty }
  end
  
  it 'should be settable' do
    @generic_message.entity_body = 'foo'
    @generic_message.entity_body.should == 'foo'
  end
end

describe Webbed::GenericMessage, 'body' do
  before do
    @klass = Class.new { include Webbed::GenericMessage }
    @generic_message = @klass.new
  end
  
  subject { @generic_message.body }
  
  it 'should have the same getter as #entity_body' do
    @generic_message.method(:body).should == @generic_message.method(:entity_body)
  end
  
  it 'should have the same setter as #entity_body' do
    @generic_message.method(:body=).should == @generic_message.method(:entity_body=)
  end
end

describe Webbed::GenericMessage, '#to_s' do
  before do
    @klass = Class.new { include Webbed::GenericMessage }
    @generic_message = @klass.new
    @generic_message.headers['Content-Type'] = 'text/plain'
    @generic_message.entity_body = 'foo'
  end
  
  subject { @generic_message }
  
  it 'should use the start line' do
    @generic_message.should_receive(:start_line)
    @generic_message.to_s
  end
  
  it 'should use the headers' do
    @generic_message.headers.should_receive(:to_s)
    @generic_message.to_s
  end
  
  it 'should use the entity body' do
    @generic_message.should_receive(:entity_body)
    @generic_message.to_s
  end
  
  it 'should be correct according to RFC 2616' do
    @generic_message.to_s.should == "Invalid Start Line\r\nContent-Type: text/plain\r\n\r\nfoo"
  end
end