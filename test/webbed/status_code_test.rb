require 'test_helper'

module WebbedTest
  class StatusCodeTest < TestCase
    test '#initialize with string' do
      status_code = Webbed::StatusCode.new('200')
      assert_equal 200, status_code.to_i
      assert_equal '200', status_code.to_s
      assert_equal 'OK', status_code.default_reason_phrase
    end
    
    test '#initialize with number' do
      status_code = Webbed::StatusCode.new(200)
      assert_equal 200, status_code.to_i
      assert_equal '200', status_code.to_s
      assert_equal 'OK', status_code.default_reason_phrase
    end
    
    test 'registeration' do
      begin
        status_code_1 = Webbed::StatusCode.register(999, 'blau')
        status_code_2 = Webbed::StatusCode.lookup(999)
        
        assert_equal 'blau', status_code_1.default_reason_phrase
        assert_same status_code_1, status_code_2
      ensure
        Webbed::StatusCode.registered.delete(999)
      end
    end
    
    test '#informational?' do
      status_code = Webbed::StatusCode.lookup(100)
      
      assert status_code.informational?
      refute status_code.successful?
      refute status_code.redirection?
      refute status_code.client_error?
      refute status_code.server_error?
      refute status_code.unknown?
      refute status_code.error?
    end
    
    test '#successful?' do
      status_code = Webbed::StatusCode.lookup(200)
      
      refute status_code.informational?
      assert status_code.successful?
      refute status_code.redirection?
      refute status_code.client_error?
      refute status_code.server_error?
      refute status_code.unknown?
      refute status_code.error?
    end
    
    test '#redirection?' do
      status_code = Webbed::StatusCode.lookup(300)
      
      refute status_code.informational?
      refute status_code.successful?
      assert status_code.redirection?
      refute status_code.client_error?
      refute status_code.server_error?
      refute status_code.unknown?
      refute status_code.error?
    end
    
    test '#client_error?' do
      status_code = Webbed::StatusCode.lookup(400)
      
      refute status_code.informational?
      refute status_code.successful?
      refute status_code.redirection?
      assert status_code.client_error?
      refute status_code.server_error?
      refute status_code.unknown?
      assert status_code.error?
    end
    
    test '#server_error?' do
      status_code = Webbed::StatusCode.lookup(500)
      
      refute status_code.informational?
      refute status_code.successful?
      refute status_code.redirection?
      refute status_code.client_error?
      assert status_code.server_error?
      refute status_code.unknown?
      assert status_code.error?
    end
    
    test '#unknown?' do
      status_code = Webbed::StatusCode.lookup(600)
      
      refute status_code.informational?
      refute status_code.successful?
      refute status_code.redirection?
      refute status_code.client_error?
      refute status_code.server_error?
      assert status_code.unknown?
      refute status_code.error?
    end
    
    test 'comparisons' do
      ok = Webbed::StatusCode.lookup(200)
      found = Webbed::StatusCode.lookup(302)
      
      assert_equal 200, ok
      assert_comparable ok, found
    end
  end
end