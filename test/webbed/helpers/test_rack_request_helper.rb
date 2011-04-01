require 'test_helper'

class TestRackRequestHelper < MiniTest::Unit::TestCase
  def test_to_rack
    rack_env = {
      'REQUEST_METHOD'  => 'GET',
      'SCRIPT_NAME'     => '',
      'PATH_INFO'       => '/test',
      'QUERY_STRING'    => 'foo=bar',
      'HTTP_HOST'       => 'google.com',
      'HTTP_ACCEPT'     => '*/*',
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
    assert_equal 'text/plain', request.headers['Content-Type']
    assert_equal '0', request.headers['Content-Length']
    assert_equal 'https', request.scheme
    assert_equal 'Foobar', request.entity_body.gets
    assert_equal Webbed::HTTPVersion::ONE_POINT_OH, request.http_version
    assert_same rack_env, request.rack_env
  end
  
  def test_to_rack_without_http_version
    request = Webbed::Request.from_rack({
      'REQUEST_METHOD' => 'GET',
      'SCRIPT_NAME'    => '',
      'PATH_INFO'      => '/test',
      'QUERY_STRING'   => 'foo=bar',
      'HTTP_HOST'      => 'google.com'
    })
    
    assert_equal Webbed::HTTPVersion::ONE_POINT_ONE, request.http_version
  end
end