require 'spec_helper'

describe Webbed::StatusCode, 'created without a status code' do
  before do
    @status_code = Webbed::StatusCode.new
  end
  
  subject { @status_code }
  
  describe 'status code' do
    subject { @status_code.status_code }
    it { should be_nil }
  end
  
  it { should_not be_informational }
  it { should_not be_a_success }
  it { should_not be_a_redirection }
  it { should_not be_a_client_error }
  it { should_not be_a_server_error }
  it { should be_unknown }
end

describe Webbed::StatusCode, 'created with a status code' do
  before do
    @status_code = Webbed::StatusCode.new(200)
  end
  
  subject { @status_code }
  
  describe 'status code' do
    subject { @status_code.status_code }
    it 'should be stored' do
      should == 200
    end
  end
end

describe Webbed::StatusCode, 'with an informational status code' do
  before do
    @status_code = Webbed::StatusCode.new(100)
  end
  
  subject { @status_code }
  
  it { should be_informational }
  it { should_not be_a_success }
  it { should_not be_a_redirection }
  it { should_not be_a_client_error }
  it { should_not be_a_server_error }
  it { should_not be_unknown }
end

describe Webbed::StatusCode, 'with a success status code' do
  before do
    @status_code = Webbed::StatusCode.new(200)
  end
  
  subject { @status_code }
  
  it { should_not be_informational }
  it { should be_a_success }
  it { should_not be_a_redirection }
  it { should_not be_a_client_error }
  it { should_not be_a_server_error }
  it { should_not be_unknown }
end

describe Webbed::StatusCode, 'with a redirect status code' do
  before do
    @status_code = Webbed::StatusCode.new(300)
  end
  
  subject { @status_code }
  
  it { should_not be_informational }
  it { should_not be_a_success }
  it { should be_a_redirection }
  it { should_not be_a_client_error }
  it { should_not be_a_server_error }
  it { should_not be_unknown }
end

describe Webbed::StatusCode, 'with a client error status code' do
  before do
    @status_code = Webbed::StatusCode.new(400)
  end
  
  subject { @status_code }
  
  it { should_not be_informational }
  it { should_not be_a_success }
  it { should_not be_a_redirection }
  it { should be_a_client_error }
  it { should_not be_a_server_error }
  it { should_not be_unknown }
end

describe Webbed::StatusCode, 'with a server error status code' do
  before do
    @status_code = Webbed::StatusCode.new(500)
  end
  
  subject { @status_code }
  
  it { should_not be_informational }
  it { should_not be_a_success }
  it { should_not be_a_redirection }
  it { should_not be_a_client_error }
  it { should be_a_server_error }
  it { should_not be_unknown }
end

describe Webbed::StatusCode, 'with an unknown status code' do
  before do
    @status_code = Webbed::StatusCode.new(600)
  end
  
  subject { @status_code }
  
  it { should_not be_informational }
  it { should_not be_a_success }
  it { should_not be_a_redirection }
  it { should_not be_a_client_error }
  it { should_not be_a_server_error }
  it { should be_unknown }
end

describe Webbed::StatusCode, 'equality' do
  before do
    @status_code = Webbed::StatusCode.new(200)
  end
  
  it 'should be equal to the numeric status code' do
    @status_code.should == 200
  end
  
  it 'should be equal to an identical status code' do
    @status_code.should == Webbed::StatusCode.new(200)
  end
  
  it 'should not be equal to a different numeric status code' do
    @status_code.should_not == 300
  end
  
  it 'should not be equal to a different status code' do
    @status_code.should_not == Webbed::StatusCode.new(300)
  end
end

describe Webbed::StatusCode, '#to_s' do
  context 'when the status code is 3 digits' do
    before do
      @status_code = Webbed::StatusCode.new(200)
    end
    
    it 'should be a string of those digits' do
      @status_code.to_s.should == '200'
    end
  end
  
  context 'when the status code is less than 3 digits' do
    before do
      @status_code = Webbed::StatusCode.new(99)
    end
    
    it 'should have leading zeroes so it becomes 3 digits' do
      @status_code.to_s.should == '099'
    end
  end
end