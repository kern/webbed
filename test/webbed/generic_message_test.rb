require 'test_helper'

module WebbedTest
  class GenericMessageTest < TestCase
    def setup
      @klass = Class.new
      @klass.instance_eval { include Webbed::GenericMessage }
      @message = @klass.new
    end
    
    test '#initialize' do
      assert_nil @message.http_version
      assert_nil @message.headers
      assert_nil @message.entity_body
    end
    
    test '#http_version' do
      @message.http_version = 'HTTP/1.0'
      
      assert_instance_of Webbed::HTTPVersion, @message.http_version
      assert_equal 1.0, @message.http_version
    end
    
    test '#headers' do
      @message.headers = { 'Host' => 'foo.com' }
      
      assert_instance_of Webbed::Headers, @message.headers
      assert_equal 'foo.com', @message.headers['Host']
    end
    
    test '#entity_body' do
      @message.entity_body = 'foo'
      assert_equal 'foo', @message.entity_body
    end
    
    test '#to_s' do
      @message.expects(:start_line).returns("Start Line\r\n")
      @message.expects(:headers).returns("Headers\r\n")
      @message.expects(:entity_body).returns('Entity Body')
      
      assert_equal "Start Line\r\nHeaders\r\n\r\nEntity Body", @message.to_s
    end
  end
end