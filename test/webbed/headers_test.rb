require 'test_helper'

# TODO: Add more tests to this. Since it was stolen from Rack, I'm pretty darn
# sure that it works correctly. Still, as a matter of principle, it should have
# all the necessary tests to make sure it works correctly when it changes. But
# yeah, very low priority at the moment.
module WebbedTest
  class HeadersTest < TestCase
    test '#initialize without headers' do
      assert Webbed::Headers.new.empty?
    end
    
    test '#initialize with headers' do
      headers = Webbed::Headers.new({ 'Host' => 'foo.com' })
      
      refute headers.empty?
      assert_equal 'foo.com', headers['Host']
      assert_equal 'foo.com', headers['host']
      assert_equal 'foo.com', headers['HOST']
    end
    
    test '#to_s' do
      headers = Webbed::Headers.new({
        'Content-Type' => 'application/json',
        'Host' => 'foo.com'
      })
      
      assert_equal "Content-Type: application/json\r\nHost: foo.com\r\n", headers.to_s
    end
  end
end