require 'spec_helper'

describe Webbed::StatusCode do
  context 'when created with a string status code' do
    subject { Webbed::StatusCode.new('200') }
    
    it 'should store the integer representation of the status code' do
      subject.status_code.should == 200
    end
    
    it 'should have a default reason phrase based on the status code' do
      subject.default_reason_phrase.should == 'OK'
    end
  end
  
  context 'when created with an integer status code' do
    subject { Webbed::StatusCode.new(400) }
    
    it 'should store the status code' do
      subject.status_code.should == 400
    end
    
    it 'should have a default reason phrase based on the status code' do
      subject.default_reason_phrase.should == 'Bad Request'
    end
  end
  
  context 'when two identical status codes are created' do
    it 'should cache them so they are exactly equal' do
      Webbed::StatusCode.new(200).should equal(Webbed::StatusCode.new(200))
    end
  end
  
  context 'when it is an informational status code' do
    subject { Webbed::StatusCode.new(100) }
    
    it { should be_informational }
    it { should_not be_a_success }
    it { should_not be_a_redirection }
    it { should_not be_a_client_error }
    it { should_not be_a_server_error }
    it { should_not be_unknown }
    it { should_not be_an_error }
  end
  
  context 'when it is a success status code' do
    subject { Webbed::StatusCode.new(200) }
    
    it { should_not be_informational }
    it { should be_a_success }
    it { should_not be_a_redirection }
    it { should_not be_a_client_error }
    it { should_not be_a_server_error }
    it { should_not be_unknown }
    it { should_not be_an_error }
  end
  
  context 'when it is a redirect status code' do
    subject { Webbed::StatusCode.new(300) }
    
    it { should_not be_informational }
    it { should_not be_a_success }
    it { should be_a_redirection }
    it { should_not be_a_client_error }
    it { should_not be_a_server_error }
    it { should_not be_unknown }
    it { should_not be_an_error }
  end
  
  context 'when it is a client error status code' do
    subject { Webbed::StatusCode.new(400) }
    
    it { should_not be_informational }
    it { should_not be_a_success }
    it { should_not be_a_redirection }
    it { should be_a_client_error }
    it { should_not be_a_server_error }
    it { should_not be_unknown }
    it { should be_an_error }
  end
  
  context 'when it is a server error status code' do
    subject { Webbed::StatusCode.new(500) }
    
    it { should_not be_informational }
    it { should_not be_a_success }
    it { should_not be_a_redirection }
    it { should_not be_a_client_error }
    it { should be_a_server_error }
    it { should_not be_unknown }
    it { should be_an_error }
  end
  
  context 'when it is an unknown status code' do
    subject { Webbed::StatusCode.new(600) }
    
    it { should_not be_informational }
    it { should_not be_a_success }
    it { should_not be_a_redirection }
    it { should_not be_a_client_error }
    it { should_not be_a_server_error }
    it { should be_unknown }
    it { should_not be_an_error }
  end
  
  describe '#==' do
    subject { Webbed::StatusCode.new(200) }
    
    it 'should be equal to the numeric status code' do
      subject.should == 200
    end
    
    it 'should be equal to an identical status code' do
      subject.should == Webbed::StatusCode.new(200)
    end
  end
  
  describe '#to_i' do
    subject { Webbed::StatusCode.new(200) }
    
    it 'should return the status code' do
      subject.to_i.should == 200
    end
  end
  
  describe '#to_s' do
    context 'when the status code is 3 digits' do
      subject { Webbed::StatusCode.new(200) }
      
      it 'should be a string of those digits' do
        subject.to_s.should == '200'
      end
    end
    
    context 'when the status code is less than 3 digits' do
      subject { Webbed::StatusCode.new(99) }
      
      it 'should have leading zeroes' do
        subject.to_s.should == '099'
      end
    end
  end
end