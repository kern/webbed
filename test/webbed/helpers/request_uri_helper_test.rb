require 'test_helper'

module WebbedTest
  module HelperTest
    class RequestURIHelperTest < TestCase
      test '#request_url' do
        request = Webbed::Request.new('GET', '/foo', { 'Host' => 'example.com' }, '')
        assert_equal request.request_uri, request.request_url
      end
      
      test '#uri and #url' do
        no_host = Webbed::Request.new('GET', '/foo', {}, '')
        assert_instance_of Addressable::URI, no_host.uri
        assert_instance_of Addressable::URI, no_host.url
        assert_equal no_host.request_uri, no_host.uri
        assert_equal no_host.request_uri, no_host.url
        
        request_uri_with_host = Webbed::Request.new('GET', 'http://example2.com/foo', { 'Host' => 'example.com' }, '')
        assert_instance_of Addressable::URI, request_uri_with_host.uri
        assert_instance_of Addressable::URI, request_uri_with_host.url
        assert_equal request_uri_with_host.request_uri, request_uri_with_host.uri
        assert_equal request_uri_with_host.request_uri, request_uri_with_host.url
        
        request_uri_without_host = Webbed::Request.new('GET', '/foo', { 'Host' => 'example.com' }, '')
        assert_instance_of Addressable::URI, request_uri_without_host.uri
        assert_instance_of Addressable::URI, request_uri_without_host.url
        assert_equal Addressable::URI.parse('http://example.com/foo'), request_uri_without_host.uri
        assert_equal Addressable::URI.parse('http://example.com/foo'), request_uri_without_host.url
      end
    end
  end
end