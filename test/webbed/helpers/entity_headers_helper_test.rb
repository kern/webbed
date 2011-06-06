require 'test_helper'

module WebbedTest
  module HelperTest
    class EntityHeadersHelperTest < TestCase
      def setup
        @request = Webbed::Request.new('GET', '*', {}, '')
        @response = Webbed::Response.new(200, {}, '')
      end
      
      test '#content_length' do
        [@request, @response].each do |message|
          assert_nil message.content_length
          
          message.headers['Content-Length'] = 9876
          assert_equal 9876, message.content_length
          
          message.content_length = 123
          assert_equal 123, message.content_length
          assert_equal '123', message.headers['Content-Length']
        end
      end
      
      test '#content_location' do
        [@request, @response].each do |message|
          assert_nil message.content_location
          
          message.headers['Content-Location'] = 'http://google.com'
          assert_instance_of Addressable::URI, message.content_location
          assert_equal 'http://google.com', message.content_location.to_s
          
          message.content_location = 'http://example.com/testing'
          assert_instance_of Addressable::URI, message.content_location
          assert_equal 'http://example.com/testing', message.content_location.to_s
          assert_equal 'http://example.com/testing', message.headers['Content-Location']
        end
      end
      
      test '#content_md5' do
        [@request, @response].each do |message|
          assert_nil message.content_md5
          
          message.headers['Content-MD5'] = 'asdfasdf'
          assert_equal 'asdfasdf', message.content_md5
          
          message.content_md5 = ';lkj;lkj'
          assert_equal ';lkj;lkj', message.content_md5
          assert_equal ';lkj;lkj', message.headers['Content-MD5']
        end
      end
      
      test '#content_type' do
        [@request, @response].each do |message|
          assert_nil message.content_type
          
          message.headers['Content-Type'] = 'text/html'
          assert_instance_of Webbed::MediaType, message.content_type
          assert_equal 'text/html', message.content_type.to_s
          
          message.content_type = 'application/json'
          assert_instance_of Webbed::MediaType, message.content_type
          assert_equal 'application/json', message.content_type.to_s
          assert_equal 'application/json', message.headers['Content-Type']
        end
      end
      
      test '#allowed_methods' do
        [@request, @response].each do |message|
          assert_nil message.allowed_methods
          
          message.headers['Allow'] = 'GET, POST,PUT'
          allowed_methods = message.allowed_methods
          ['GET', 'POST', 'PUT'].each.with_index do |method, index|
            allowed_method = allowed_methods[index]
            assert_instance_of Webbed::Method, allowed_method
            assert_equal method, allowed_method.to_s
          end
          
          message.allowed_methods = ['DELETE', Webbed::Method::OPTIONS]
          assert_equal 'DELETE, OPTIONS', message.headers['Allow']
          allowed_methods = message.allowed_methods
          ['DELETE', 'OPTIONS'].each.with_index do |method, index|
            allowed_method = allowed_methods[index]
            assert_instance_of Webbed::Method, allowed_method
            assert_equal method, allowed_method.to_s
          end
        end
      end
    end
  end
end