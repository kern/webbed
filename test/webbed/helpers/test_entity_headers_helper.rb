require 'test_helper'

class TestEntityHeadersHelper < MiniTest::Unit::TestCase
  def setup
    @request = Webbed::Request.new(['GET', '*', {}, ''])
    @response = Webbed::Response.new([200, {}, ''])
  end
  
  def test_content_length
    [@request, @response].each do |message|
      assert_nil message.content_length
      
      message.headers['Content-Length'] = 9876
      assert_equal 9876, message.content_length
      
      message.content_length = 123
      assert_equal 123, message.content_length
      assert_equal '123', message.headers['Content-Length']
    end
  end
  
  def test_content_location
    [@request, @response].each do |message|
      assert_nil message.content_location
      
      message.headers['Content-Location'] = 'http://google.com'
      assert_instance_of Addressable::URI, message.content_location
      assert_equal Addressable::URI.parse('http://google.com'), message.content_location
      
      message.content_location = 'http://example.com/testing'
      assert_instance_of Addressable::URI, message.content_location
      assert_equal Addressable::URI.parse('http://example.com/testing'), message.content_location
      assert_equal 'http://example.com/testing', message.headers['Content-Location']
    end
  end
end