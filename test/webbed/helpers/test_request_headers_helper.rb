require 'test_helper'

class TestRequestHeadersHelper < MiniTest::Unit::TestCase
  def setup
    @request = Webbed::Request.new(['GET', '*', {}, ''])
  end
  
  def test_host
    assert_nil @request.host
    
    @request.headers['Host'] = 'example.com'
    assert_equal 'example.com', @request.host
    
    @request.host = 'test.com'
    assert_equal 'test.com', @request.host
    assert_equal 'test.com', @request.headers['Host']
  end
  
  def test_from
    assert_nil @request.from
    
    @request.headers['From'] = 'test@example.com'
    assert_equal 'test@example.com', @request.from
    
    @request.from = 'foo@bar.com'
    assert_equal 'foo@bar.com', @request.from
    assert_equal 'foo@bar.com', @request.headers['From']
  end
  
  def test_max_forwards
    assert_nil @request.max_forwards
    
    @request.headers['Max-Forwards'] = '56'
    assert_equal 56, @request.max_forwards
    
    @request.max_forwards = 1234
    assert_equal 1234, @request.max_forwards
    assert_equal '1234', @request.headers['Max-Forwards']
  end
  
  def test_referer
    assert_nil @request.referer
    
    @request.headers['Referer'] = 'http://foo.com'
    assert_instance_of Addressable::URI, @request.referer
    assert_equal Addressable::URI.parse('http://foo.com'), @request.referer
    
    @request.referer = 'http://example.com'
    assert_instance_of Addressable::URI, @request.referer
    assert_equal Addressable::URI.parse('http://example.com'), @request.referer
    assert_equal 'http://example.com', @request.headers['Referer']
  end
end