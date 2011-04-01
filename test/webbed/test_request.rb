require 'test_helper'

class TestRequest < MiniTest::Unit::TestCase
  def test_initialize_without_options
    request = Webbed::Request.new([
      'POST',
      'http://google.com',
      { 'Content-Type' => 'text/plain' },
      'Test 1 2 3'
    ])
    
    assert_equal Webbed::Method::POST, request.method
    assert_instance_of Addressable::URI, request.request_uri
    assert_equal 'http://google.com', request.request_uri.to_s
    assert_equal 'text/plain', request.headers['Content-Type']
    assert_equal 'Test 1 2 3', request.entity_body
    assert_equal Webbed::HTTPVersion::ONE_POINT_ONE, request.http_version
    assert_equal 'http', request.scheme
  end
  
  def test_initialize_with_http_version
    request = Webbed::Request.new([
      'POST',
      'http://google.com',
      { 'Content-Type' => 'text/plain' },
      'Test 1 2 3'
    ], :http_version => 1.0)
    
    assert_equal Webbed::HTTPVersion::ONE_POINT_OH, request.http_version
  end
  
  def test_initialize_with_scheme
    request = Webbed::Request.new([
      'POST',
      'http://google.com',
      { 'Content-Type' => 'text/plain' },
      'Test 1 2 3'
    ], :scheme => 'https')
    
    assert_equal 'https', request.scheme
  end
  
  def test_method
    request = Webbed::Request.new([
      'POST',
      'http://google.com',
      { 'Content-Type' => 'text/plain' },
      'Test 1 2 3'
    ])
    
    request.method = 'GET'
    
    assert_instance_of Webbed::Method, request.method
    assert_equal Webbed::Method::GET, request.method
    
    assert_instance_of Method, request.method(:__send__)
  end
  
  def test_scheme
    request = Webbed::Request.new([
      'POST',
      'http://google.com',
      { 'Content-Type' => 'text/plain' },
      'Test 1 2 3'
    ])
    
    request.scheme = 'https'
    assert_equal 'https', request.scheme
  end
end