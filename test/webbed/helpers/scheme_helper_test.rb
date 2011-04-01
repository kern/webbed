require 'test_helper'

class SchemeHelperTest < MiniTest::Unit::TestCase
  def test_http_scheme
    request = Webbed::Request.new(['GET', '*', {}, ''], :scheme => 'http')
    
    refute request.secure?
    assert_equal 80, request.default_port
  end
  
  def test_https_scheme
    request = Webbed::Request.new(['GET', '*', {}, ''], :scheme => 'https')
    
    assert request.secure?
    assert_equal 443, request.default_port
  end
  
  def test_unknown_scheme
    request = Webbed::Request.new(['GET', '*', {}, ''], :scheme => 'foo')
    
    refute request.secure?
    assert_nil request.default_port
  end
end