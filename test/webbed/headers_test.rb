require 'test_helper'

# TODO: Add more tests to this. Since it was stolen from Rack, I'm pretty darn
# sure that it works correctly. Still, as a matter of principle, it should have
# all the necessary tests to make sure it works correctly when it changes. But
# yeah, very low priority at the moment.
class HeadersTest < MiniTest::Unit::TestCase
  def test_initialize_without_headers
    headers = Webbed::Headers.new
    assert headers.empty?
  end
  
  def test_initialize_with_headers
    headers = Webbed::Headers.new({ 'Host' => 'foo.com' })
    
    refute headers.empty?
    assert_equal 'foo.com', headers['Host']
    assert_equal 'foo.com', headers['host']
    assert_equal 'foo.com', headers['HOST']
  end
  
  def test_to_s
    headers = Webbed::Headers.new({
      'Content-Type' => 'application/json',
      'Host' => 'foo.com'
    })
    
    assert_equal "Content-Type: application/json\r\nHost: foo.com\r\n", headers.to_s
  end
end