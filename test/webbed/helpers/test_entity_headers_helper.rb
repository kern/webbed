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
  
  def test_content_md5
    [@request, @response].each do |message|
      assert_nil message.content_md5
      
      message.headers['Content-MD5'] = 'asdfasdf'
      assert_equal 'asdfasdf', message.content_md5
      
      message.content_md5 = ';lkj;lkj'
      assert_equal ';lkj;lkj', message.content_md5
      assert_equal ';lkj;lkj', message.headers['Content-MD5']
    end
  end
  
  def test_content_type
    [@request, @response].each do |message|
      assert_nil message.content_type
      
      message.headers['Content-Type'] = 'text/html'
      assert_instance_of Webbed::MediaType, message.content_type
      assert_equal Webbed::MediaType.new('text/html'), message.content_type
      
      message.content_type = 'application/json'
      assert_instance_of Webbed::MediaType, message.content_type
      assert_equal Webbed::MediaType.new('application/json'), message.content_type
      assert_equal 'application/json', message.headers['Content-Type']
    end
  end
end