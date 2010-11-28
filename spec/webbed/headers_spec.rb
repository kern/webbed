require 'spec_helper'

# TODO: Add more tests to this. Since it was stolen from Rack, I'm pretty darn
# sure that it works correctly. Still, at a matter of principle, it should have
# all the necessary tests to make sure it works correctly when it changes. But
# yeah, very low priority at the moment. Just a note for the future.
describe Webbed::Headers do
  subject { headers }
  let(:headers) do
    Webbed::Headers.new({
      'Content-Type' => 'application/json',
      'Host' => 'foo.com'
    })
  end
  
  context "when created without arguments" do
    let(:headers) { Webbed::Headers.new }
    it { should be_empty }
  end
  
  context "when created with headers" do
    it { should_not be_empty }
    
    it 'should set #headers' do
      headers['Content-Type'].should == 'application/json'
      headers['Host'].should == 'foo.com'
    end
  end
  
  describe "#to_s" do
    it "should join all the headers together with CRLF's after each one" do
      headers.to_s.should == "Content-Type: application/json\r\nHost: foo.com\r\n"
    end
  end
end