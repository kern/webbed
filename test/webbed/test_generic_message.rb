require 'test_helper'

class TestGenericMessage < MiniTest::Unit::TestCase
  def setup
    @klass = Class.new
    @klass.instance_eval { include Webbed::GenericMessage }
    @message = @klass.new
  end
  
  def test_initialize
    assert_nil @message.http_version
    assert_nil @message.headers
    assert_nil @message.entity_body
  end
  
  def test_http_version
    @message.http_version = 'HTTP/1.0'
    
    assert_instance_of Webbed::HTTPVersion, @message.http_version
    assert_equal 1.0, @message.http_version
  end
  
  def test_headers
    @message.headers = { 'Host' => 'foo.com' }
    
    assert_instance_of Webbed::Headers, @message.headers
    assert_equal 'foo.com', @message.headers['Host']
  end
  
  def test_entity_body
    @message.entity_body = 'foo'
    assert_equal 'foo', @message.entity_body
  end
  
  def test_to_s
    @message.expects(:start_line).returns("Start Line\r\n")
    @message.expects(:headers).returns("Headers\r\n")
    @message.expects(:entity_body).returns('Entity Body')
    
    assert_equal "Start Line\r\nHeaders\r\n\r\nEntity Body", @message.to_s
  end
end