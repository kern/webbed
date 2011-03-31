require 'test_helper'

class StatusCodeTest < MiniTest::Unit::TestCase
  def test_initialize_with_string
    status_code = Webbed::StatusCode.new('200')
    assert_equal 200, status_code.to_i
    assert_equal '200', status_code.to_s
    assert_equal 'OK', status_code.default_reason_phrase
  end
  
  def test_initialize_with_fixnum
    status_code = Webbed::StatusCode.new(200)
    assert_equal 200, status_code.to_i
    assert_equal '200', status_code.to_s
    assert_equal 'OK', status_code.default_reason_phrase
  end
  
  def test_caching
    status_code_1 = Webbed::StatusCode.new(200)
    status_code_2 = Webbed::StatusCode.new(200)
    assert_same status_code_2, status_code_1
  end
  
  def test_informational
    status_code = Webbed::StatusCode.new(100)
    
    assert status_code.informational?
    refute status_code.successful?
    refute status_code.redirection?
    refute status_code.client_error?
    refute status_code.server_error?
    refute status_code.unknown?
    refute status_code.error?
  end
  
  def test_successful
    status_code = Webbed::StatusCode.new(200)
    
    refute status_code.informational?
    assert status_code.successful?
    refute status_code.redirection?
    refute status_code.client_error?
    refute status_code.server_error?
    refute status_code.unknown?
    refute status_code.error?
  end
  
  def test_redirection
    status_code = Webbed::StatusCode.new(300)
    
    refute status_code.informational?
    refute status_code.successful?
    assert status_code.redirection?
    refute status_code.client_error?
    refute status_code.server_error?
    refute status_code.unknown?
    refute status_code.error?
  end
  
  def test_client_error
    status_code = Webbed::StatusCode.new(400)
    
    refute status_code.informational?
    refute status_code.successful?
    refute status_code.redirection?
    assert status_code.client_error?
    refute status_code.server_error?
    refute status_code.unknown?
    assert status_code.error?
  end
  
  def test_server_error
    status_code = Webbed::StatusCode.new(500)
    
    refute status_code.informational?
    refute status_code.successful?
    refute status_code.redirection?
    refute status_code.client_error?
    assert status_code.server_error?
    refute status_code.unknown?
    assert status_code.error?
  end
  
  def test_unknown
    status_code = Webbed::StatusCode.new(600)
    
    refute status_code.informational?
    refute status_code.successful?
    refute status_code.redirection?
    refute status_code.client_error?
    refute status_code.server_error?
    assert status_code.unknown?
    refute status_code.error?
  end
  
  def test_comparable
    ok = Webbed::StatusCode.new(200)
    found = Webbed::StatusCode.new(302)
    
    refute_equal ok, found
    assert ok < found
    assert found > ok
  end
end