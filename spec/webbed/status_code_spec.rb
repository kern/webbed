require 'spec_helper'

describe Webbed::StatusCode do
  before do
    @status_code = Webbed::StatusCode.new(200)
  end
  
  it 'should store the status code' do
    @status_code.status_code.should == 200
  end
  
  describe '#to_s' do
    context 'when the code is three digits long' do
      it 'should be a string of the digits' do
        @status_code.to_s.should == '200'
      end
    end
    
    context 'when the code is less than three digits' do
      it 'should have leading zeroes to three digits' do
        Webbed::StatusCode.new(10).to_s.should == '010'
      end
    end
  end
  
  describe 'informational status codes' do
    it 'should be informational for 100' do
      Webbed::StatusCode.new(100).should be_informational
    end
    
    it 'should be informational for 102' do
      Webbed::StatusCode.new(102).should be_informational
    end
    
    it 'should be informational for 199' do
      Webbed::StatusCode.new(199).should be_informational
    end
    
    it 'should not be informational for 200' do
      Webbed::StatusCode.new(200).should_not be_informational
    end
    
    it 'should not be informational for 500' do
      Webbed::StatusCode.new(500).should_not be_informational
    end
    
    it 'should not be informational for 099' do
      Webbed::StatusCode.new(99).should_not be_informational
    end
  end
  
  describe 'successful status codes' do
    it 'should be successful for 200' do
      Webbed::StatusCode.new(200).should be_a_success
    end
    
    it 'should be successful for 202' do
      Webbed::StatusCode.new(202).should be_a_success
    end
    
    it 'should be successful for 299' do
      Webbed::StatusCode.new(299).should be_a_success
    end
    
    it 'should not be successful for 300' do
      Webbed::StatusCode.new(300).should_not be_a_success
    end
    
    it 'should not be successful for 500' do
      Webbed::StatusCode.new(500).should_not be_a_success
    end
    
    it 'should not be successful for 199' do
      Webbed::StatusCode.new(199).should_not be_a_success
    end
  end
  
  describe 'redirction status codes' do
    it 'should be a redirection for 300' do
      Webbed::StatusCode.new(300).should be_a_redirection
    end
    
    it 'should be a redirection for 302' do
      Webbed::StatusCode.new(302).should be_a_redirection
    end
    
    it 'should be a redirection for 399' do
      Webbed::StatusCode.new(399).should be_a_redirection
    end
    
    it 'should not be a redirection for 400' do
      Webbed::StatusCode.new(400).should_not be_a_redirection
    end
    
    it 'should not be a redirection for 500' do
      Webbed::StatusCode.new(500).should_not be_a_redirection
    end
    
    it 'should not be a redirection for 299' do
      Webbed::StatusCode.new(299).should_not be_a_redirection
    end
  end
  
  describe 'client error status codes' do
    it 'should be a client error for 400' do
      Webbed::StatusCode.new(400).should be_a_client_error
    end
    
    it 'should be a client error for 402' do
      Webbed::StatusCode.new(402).should be_a_client_error
    end
    
    it 'should be a client error for 499' do
      Webbed::StatusCode.new(499).should be_a_client_error
    end
    
    it 'should not be a client error for 500' do
      Webbed::StatusCode.new(500).should_not be_a_client_error
    end
    
    it 'should not be a client error for 200' do
      Webbed::StatusCode.new(200).should_not be_a_client_error
    end
    
    it 'should not be a client error for 399' do
      Webbed::StatusCode.new(399).should_not be_a_client_error
    end
  end
  
  describe 'server error status codes' do
    it 'should be a server error for 500' do
      Webbed::StatusCode.new(500).should be_a_server_error
    end
    
    it 'should be a server error for 502' do
      Webbed::StatusCode.new(502).should be_a_server_error
    end
    
    it 'should be a server error for 599' do
      Webbed::StatusCode.new(599).should be_a_server_error
    end
    
    it 'should not be a server error for 600' do
      Webbed::StatusCode.new(600).should_not be_a_server_error
    end
    
    it 'should not be a server error for 200' do
      Webbed::StatusCode.new(200).should_not be_a_server_error
    end
    
    it 'should not be a server error for 499' do
      Webbed::StatusCode.new(499).should_not be_a_server_error
    end
  end
  
  describe 'unknown status codes' do
    it 'should be unknown for 600' do
      Webbed::StatusCode.new(600).should be_unknown
    end
    
    it 'should be unknown for 702' do
      Webbed::StatusCode.new(702).should be_unknown
    end
    
    it 'should be unknown for 099' do
      Webbed::StatusCode.new(99).should be_unknown
    end
    
    it 'should be unknown for 050' do
      Webbed::StatusCode.new(050).should be_unknown
    end
    
    it 'should not be unknown for 100' do
      Webbed::StatusCode.new(100).should_not be_unknown
    end
    
    it 'should not be unknown for 300' do
      Webbed::StatusCode.new(300).should_not be_unknown
    end
    
    it 'should not be unknown for 599' do
      Webbed::StatusCode.new(599).should_not be_unknown
    end
  end
  
  describe 'error status codes' do
    it 'should be an error for 400' do
      Webbed::StatusCode.new(400).should be_an_error
    end
    
    it 'should be an error for 499' do
      Webbed::StatusCode.new(499).should be_an_error
    end
    
    it 'should be an error for 500' do
      Webbed::StatusCode.new(500).should be_an_error
    end
    
    it 'should be an error for 599' do
      Webbed::StatusCode.new(599).should be_an_error
    end
    
    it 'should not be an error for 600' do
      Webbed::StatusCode.new(600).should_not be_an_error
    end
    
    it 'should not be an error for 650' do
      Webbed::StatusCode.new(650).should_not be_an_error
    end
    
    it 'should not be an error for 200' do
      Webbed::StatusCode.new(200).should_not be_an_error
    end
    
    it 'should not be an error for 300' do
      Webbed::StatusCode.new(300).should_not be_an_error
    end
  end
end