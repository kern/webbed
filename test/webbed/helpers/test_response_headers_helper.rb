require 'test_helper'

class TestResponseHeadersHelper < MiniTest::Unit::TestCase
  def setup
    @response = Webbed::Response.new([200, {}, '']) 
  end
  
  def test_etag
    assert_nil @response.etag
    
    @response.headers['ETag'] = 'asdf'
    assert_equal 'asdf', @response.etag
    
    @response.etag = 'foo'
    assert_equal 'foo', @response.etag
    assert_equal 'foo', @response.headers['ETag']
  end
  
  def test_age
    assert_nil @response.age
    
    @response.headers['Age'] = '123'
    assert_equal 123, @response.age
    
    @response.age = 456
    assert_equal 456, @response.age
    assert_equal '456', @response.headers['Age']
  end
  
  def test_location
    assert_nil @response.location
    
    @response.headers['Location'] = 'http://example.com/test'
    assert_instance_of Addressable::URI, @response.location
    assert_equal Addressable::URI.parse('http://example.com/test'), @response.location
    
    @response.location = 'http://test.com/foo'
    assert_instance_of Addressable::URI, @response.location
    assert_equal Addressable::URI.parse('http://test.com/foo'), @response.location
    assert_equal 'http://test.com/foo', @response.headers['Location']
  end
end