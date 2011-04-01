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
end