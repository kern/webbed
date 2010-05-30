require 'spec_helper'

describe Webbed::Method, 'created with just a method name' do
  before do
    @method = Webbed::Method.new('FAKE')
  end
  
  subject { @method }
  
  describe 'method name' do
    subject { @method.name }
    it 'should be stored' do
      should == 'FAKE'
    end
  end
  
  it { should_not be_safe }
  it { should_not be_idempotent }
  specify { subject.has_request_entity?.should be_true }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'created as a safe method' do
  before do
    @method = Webbed::Method.new('FAKE', :safe)
  end
  
  subject { @method }
  
  it { should be_safe }
  it { should be_idempotent }
  specify { subject.has_request_entity?.should be_true }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'created as an idempotent method' do
  before do
    @method = Webbed::Method.new('FAKE', :idempotent)
  end
  
  subject { @method }
  
  it { should_not be_safe }
  it { should be_idempotent }
  specify { subject.has_request_entity?.should be_true }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'created as an unsafe method' do
  before do
    @method = Webbed::Method.new('FAKE', :unsafe)
  end
  
  subject { @method }
  
  it { should_not be_safe }
  it { should_not be_idempotent }
  specify { subject.has_request_entity?.should be_true }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'created as a headers only method' do
  before do
    @method = Webbed::Method.new('HEAD', :safe, :no_entities)
  end
  
  subject { @method }
  
  specify { subject.has_request_entity?.should be_false }
  specify { subject.has_response_entity?.should be_false }
end

describe Webbed::Method, 'created as a response entity only method' do
  before do
    @method = Webbed::Method.new('GET', :safe, :only_response_entity)
  end
  
  subject { @method }
  
  specify { subject.has_request_entity?.should be_false }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'created as a two entity method' do
  before do
    @method = Webbed::Method.new('POST', :unsafe, :both_entities)
  end
  
  subject { @method }
  
  specify { subject.has_request_entity?.should be_true }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'equality' do
  subject { Webbed::Method::POST }
  
  it 'should equal the method name' do
    should == 'POST'
  end
  
  it 'should equal an identical method' do
    should == Webbed::Method::POST
  end

  it 'should not equal a different method name' do
    should_not == 'PUT'
  end
  
  it 'should not equal a different method' do
    should_not == Webbed::Method::PUT
  end
end

describe Webbed::Method, '#to_s' do
  it 'should return the name of the method' do
    Webbed::Method::POST.to_s.should == 'POST'
  end
end
  
describe Webbed::Method, 'OPTIONS method' do
  subject { Webbed::Method::OPTIONS }
  specify { subject.name.should == 'OPTIONS' }
  it { should be_safe }
  it { should be_idempotent }
  specify { subject.has_request_entity?.should be_false }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'GET method' do
  subject { Webbed::Method::GET }
  specify { subject.name.should == 'GET' }
  it { should be_safe }
  it { should be_idempotent }
  specify { subject.has_request_entity?.should be_false }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'HEAD method' do
  subject { Webbed::Method::HEAD }
  specify { subject.name.should == 'HEAD' }
  it { should be_safe }
  it { should be_idempotent }
  specify { subject.has_request_entity?.should be_false }
  specify { subject.has_response_entity?.should be_false }
end

describe Webbed::Method, 'POST method' do
  subject { Webbed::Method::POST }
  specify { subject.name.should == 'POST' }
  it { should_not be_safe }
  it { should_not be_idempotent }
  specify { subject.has_request_entity?.should be_true }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'PUT method' do
  subject { Webbed::Method::PUT }
  specify { subject.name.should == 'PUT' }
  it { should_not be_safe }
  it { should be_idempotent }
  specify { subject.has_request_entity?.should be_true }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'DELETE method' do
  subject { Webbed::Method::DELETE }
  specify { subject.name.should == 'DELETE' }
  it { should_not be_safe }
  it { should be_idempotent }
  specify { subject.has_request_entity?.should be_false }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'TRACE method' do
  subject { Webbed::Method::TRACE }
  specify { subject.name.should == 'TRACE' }
  it { should be_safe }
  it { should be_idempotent }
  specify { subject.has_request_entity?.should be_false }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'CONNECT method' do
  subject { Webbed::Method::CONNECT }
  specify { subject.name.should == 'CONNECT' }
  it { should_not be_safe }
  it { should_not be_idempotent }
  specify { subject.has_request_entity?.should be_true }
  specify { subject.has_response_entity?.should be_true }
end

describe Webbed::Method, 'PATCH method' do
  subject { Webbed::Method::PATCH }
  specify { subject.name.should == 'PATCH' }
  it { should_not be_safe }
  it { should_not be_idempotent }
  specify { subject.has_request_entity?.should be_true }
  specify { subject.has_response_entity?.should be_true }
end