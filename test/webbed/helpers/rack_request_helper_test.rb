require 'test_helper'

module WebbedTest
  module HelperTest
    class RackRequestHelperTest < TestCase
      test '.from_rack' do
        rack_env = {
          'REQUEST_METHOD'  => 'GET',
          'PATH_INFO'       => '/test',
          'QUERY_STRING'    => 'foo=bar',
          'HTTP_HOST'       => 'google.com',
          'HTTP_ACCEPT'     => '*/*',
          'HTTP_IF_MATCH'   => 'foo',
          'CONTENT_TYPE'    => 'text/plain',
          'CONTENT_LENGTH'  => '0',
          'HTTP_VERSION'    => 'HTTP/1.0',
          'rack.url_scheme' => 'https',
          'rack.input'      => StringIO.new('Foobar')
        }
        
        request = Webbed::Request.from_rack(rack_env)
        
        assert_equal Webbed::Method::GET, request.method
        assert_equal Addressable::URI.parse('/test?foo=bar'), request.request_uri
        assert_equal 'google.com', request.headers['Host']
        assert_equal '*/*', request.headers['Accept']
        assert_equal 'foo', request.headers['If-Match']
        assert_equal 'text/plain', request.headers['Content-Type']
        assert_equal '0', request.headers['Content-Length']
        assert_equal 'https', request.scheme
        assert_equal 'Foobar', request.entity_body.gets
        assert_equal Webbed::HTTPVersion::ONE_POINT_OH, request.http_version
        assert_same rack_env, request.rack_env
      end
      
      test '.from_rack without an HTTP Version' do
        request = Webbed::Request.from_rack({
          'REQUEST_METHOD' => 'GET',
          'PATH_INFO'      => '/test',
          'QUERY_STRING'   => 'foo=bar',
          'HTTP_HOST'      => 'google.com'
        })
        
        assert_equal Webbed::HTTPVersion::ONE_POINT_ONE, request.http_version
      end
      
      test '#to_rack without an environment' do
        string_io = StringIO.new('Foobar')
        
        request = Webbed::Request.new('GET', '/test?foo=bar', {
          'Host' => 'google.com',
          'Accept' => '*/*',
          'Content-Type' => 'text/plain',
          'Content-Length' => '0'
        }, string_io, :http_version => 1.0, :scheme => 'https')
        
        assert_equal({
          'REQUEST_METHOD'  => 'GET',
          'PATH_INFO'       => '/test',
          'QUERY_STRING'    => 'foo=bar',
          'HTTP_HOST'       => 'google.com',
          'HTTP_ACCEPT'     => '*/*',
          'CONTENT_TYPE'    => 'text/plain',
          'CONTENT_LENGTH'  => '0',
          'HTTP_VERSION'    => 'HTTP/1.0',
          'rack.url_scheme' => 'https',
          'rack.input'      => string_io
        }, request.to_rack)
      end
      
      test '#to_rack with an environment' do
        string_io = StringIO.new('Foobar')
        
        request = Webbed::Request.from_rack({
          'REQUEST_METHOD'  => 'GET',
          'PATH_INFO'       => '/test',
          'QUERY_STRING'    => 'foo=bar',
          'HTTP_HOST'       => 'google.com',
          'HTTP_ACCEPT'     => '*/*',
          'HTTP_IF_MATCH'   => 'foo',
          'CONTENT_TYPE'    => 'text/plain',
          'CONTENT_LENGTH'  => '0',
          'HTTP_VERSION'    => 'HTTP/1.0',
          'rack.url_scheme' => 'https',
          'rack.input'      => string_io,
          'my.extension'    => 'test'
        })
        
        request.method = 'POST'
        
        assert_equal({
          'REQUEST_METHOD'  => 'POST',
          'PATH_INFO'       => '/test',
          'QUERY_STRING'    => 'foo=bar',
          'HTTP_HOST'       => 'google.com',
          'HTTP_ACCEPT'     => '*/*',
          'HTTP_IF_MATCH'   => 'foo',
          'CONTENT_TYPE'    => 'text/plain',
          'CONTENT_LENGTH'  => '0',
          'HTTP_VERSION'    => 'HTTP/1.0',
          'rack.url_scheme' => 'https',
          'rack.input'      => string_io,
          'my.extension'    => 'test'
        }, request.to_rack)
      end
    end
  end
end