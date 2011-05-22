require 'test_helper'

module WebbedTest
  class ResponseTest < TestCase
    test '#initialize without options' do
      response = Webbed::Response.new(
        404,
        { 'Content-Type' => 'text/plain' },
        'Test 1 2 3'
      )
      
      assert_equal 'text/plain', response.headers['Content-Type']
      assert_equal 'Test 1 2 3', response.entity_body
      assert_equal Webbed::HTTPVersion::ONE_POINT_ONE, response.http_version
    end
    
    test '#initialize with a Reason Phrase' do
      response = Webbed::Response.new(
        '200 LOLOL',
        {},
        'Test 1 2 3'
      )
      
      assert_equal 'LOLOL', response.reason_phrase
      
      assert_instance_of Webbed::StatusCode, response.status_code
      assert_equal 200, response.status_code
    end
    
    test '#initialize without a Reason Phrase' do
      response = Webbed::Response.new(
        404,
        {},
        'Test 1 2 3'
      )
      
      assert_equal 'Not Found', response.reason_phrase
      
      assert_instance_of Webbed::StatusCode, response.status_code
      assert_equal 404, response.status_code
    end
    
    test '#initialize with an HTTP Version' do
      response = Webbed::Response.new(
        404,
        {},
        'Test 1 2 3',
        :http_version => 1.0
      )
      
      assert_equal Webbed::HTTPVersion::ONE_POINT_OH, response.http_version
    end
    
    test '#status_code' do
      response = Webbed::Response.new(
        404,
        {},
        'Test 1 2 3'
      )
      
      assert_instance_of Webbed::StatusCode, response.status_code
      assert_equal 404, response.status_code
      
      response.status_code = 100
      
      assert_instance_of Webbed::StatusCode, response.status_code
      assert_equal 100, response.status_code
    end
    
    test '#reason_phrase' do
      response = Webbed::Response.new(
        500,
        {},
        'Test 1 2 3'
      )
      
      assert_equal 'Internal Server Error', response.reason_phrase
      
      response.status_code = 404
      assert_equal 'Not Found', response.reason_phrase
      
      response.reason_phrase = 'FOOBAR'
      assert_equal 'FOOBAR', response.reason_phrase
    end
  end
end