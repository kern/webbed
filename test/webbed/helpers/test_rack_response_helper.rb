require 'test_helper'

class TestRackResponseHelper < MiniTest::Unit::TestCase
  def test_to_rack
    response = Webbed::Response.new([200, {}, ''])
    assert_equal [200, {}, ''], response.to_rack
  end
  
  def test_to_a
    response = Webbed::Response.new([200, {}, ''])
    assert_equal ['200 OK', {}, ''], response.to_a
  end
end