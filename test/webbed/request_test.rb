require 'test_helper'

module WebbedTest
  class RequestTest < TestCase
    test '#initialize without options' do
      request = Webbed::Request.new(
        'POST',
        'http://google.com',
        { 'Content-Type' => 'text/plain' },
        'Test 1 2 3'
      )
      
      assert_equal Webbed::Method::POST, request.method
      assert_instance_of Addressable::URI, request.request_uri
      assert_equal 'http://google.com', request.request_uri.to_s
      assert_equal 'text/plain', request.headers['Content-Type']
      assert_equal 'Test 1 2 3', request.entity_body
      assert_equal Webbed::HTTPVersion::ONE_POINT_ONE, request.http_version
      assert_equal 'http', request.scheme
    end
    
    test '#initialize with an HTTP Version' do
      request = Webbed::Request.new(
        'POST',
        'http://google.com',
        { 'Content-Type' => 'text/plain' },
        'Test 1 2 3',
        :http_version => 1.0
      )
      
      assert_equal Webbed::HTTPVersion::ONE_POINT_OH, request.http_version
    end
    
    test '#initialize with a scheme' do
      request = Webbed::Request.new(
        'POST',
        'http://google.com',
        { 'Content-Type' => 'text/plain' },
        'Test 1 2 3',
        :scheme => 'https'
      )
      
      assert_equal 'https', request.scheme
    end
    
    test '#method' do
      request = Webbed::Request.new(
        'POST',
        'http://google.com',
        { 'Content-Type' => 'text/plain' },
        'Test 1 2 3'
      )
      
      request.method = 'GET'
      
      assert_instance_of Webbed::Method, request.method
      assert_equal Webbed::Method::GET, request.method
      
      assert_instance_of Method, request.method(:__send__)
    end
    
    test '#scheme' do
      request = Webbed::Request.new(
        'POST',
        'http://google.com',
        { 'Content-Type' => 'text/plain' },
        'Test 1 2 3'
      )
      
      request.scheme = 'https'
      assert_equal 'https', request.scheme
    end
  end
end