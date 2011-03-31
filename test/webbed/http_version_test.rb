require 'test_helper'

class HTTPVersionTest < MiniTest::Unit::TestCase
  def test_create_with_string
    version = Webbed::HTTPVersion.new('HTTP/1.1')
    assert_equal 1, version.major
    assert_equal 1, version.minor
  end
  
  def test_create_with_float
    version = Webbed::HTTPVersion.new('HTTP/2.0')
    assert_equal 2, version.major
    assert_equal 0, version.minor
  end
end