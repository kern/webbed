require 'spec_helper'

# TODO: Add more tests to this. Since it was stolen from Rack, I'm pretty darn
# sure that it works correctly. Still, at a matter of principle, it should have
# all the necessary tests to make sure it works correctly when it changes. But
# yeah, very low priority at the moment. Just a note for the future.
describe Webbed::Headers do
  context 'when created without arguments' do
    subject { Webbed::Headers.new }
    it { should be_empty }
  end
  
  context 'when created with headers' do
    subject do
      Webbed::Headers.new(
        'Content-Type' => 'application/json',
        'Host' => 'foo.com'
      )
    end
    
    it { should_not be_empty }
    
    it 'should store the headers' do
      subject['Content-Type'].should == 'application/json'
      subject['Host'].should == 'foo.com'
    end
  end
  
  describe '#to_s' do
    before do
      @headers = Webbed::Headers.new(
        'Content-Type' => 'application/json',
        'Host' => 'foo.com'
      )
    end
    
    subject { @headers.to_s }
    
    it "should join all the headers together with CRLF's after each one" do
      should == "Content-Type: application/json\r\nHost: foo.com\r\n"
    end
  end
end