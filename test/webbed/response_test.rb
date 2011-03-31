require 'test_helper'

class ResponseTest < MiniTest::Unit::TestCase
  def test_initialize_without_options
    response = Webbed::Response.new([
      404,
      { 'Content-Type' => 'text/plain' },
      'Test 1 2 3'
    ])
    
    assert_equal 'text/plain', response.headers['Content-Type']
    assert_equal 'Test 1 2 3', response.entity_body
    assert_equal Webbed::HTTPVersion::ONE_POINT_ONE, response.http_version
  end
  
  def test_initialize_with_reason_phrase
    response = Webbed::Response.new([
      '200 LOLOL',
      {},
      'Test 1 2 3'
    ])
    
    assert_equal 'LOLOL', response.reason_phrase
    
    assert_instance_of Webbed::StatusCode, response.status_code
    assert_equal 200, response.status_code
  end
  
  def test_initialize_without_reason_phrase
    response = Webbed::Response.new([
      404,
      {},
      'Test 1 2 3'
    ])
    
    assert_equal 'Not Found', response.reason_phrase
    
    assert_instance_of Webbed::StatusCode, response.status_code
    assert_equal 404, response.status_code
  end
  
  def test_initialize_with_http_version
    response = Webbed::Response.new([
      404,
      {},
      'Test 1 2 3'
    ], :http_version => 1.0)
    
    assert_equal Webbed::HTTPVersion::ONE_POINT_OH, response.http_version
  end
  
  def test_status_code_and_reason_phrase
    response = Webbed::Response.new([
      404,
      {},
      'Test 1 2 3'
    ])
    
    response.status_code = 500
    
    assert_instance_of Webbed::StatusCode, response.status_code
    assert_equal 500, response.status_code
    assert_equal 'Internal Server Error', response.reason_phrase
    
    response.reason_phrase = 'FOOBAR'
    response.status_code = 100
    
    assert_instance_of Webbed::StatusCode, response.status_code
    assert_equal 100, response.status_code
    assert_equal 'FOOBAR', response.reason_phrase
  end
end