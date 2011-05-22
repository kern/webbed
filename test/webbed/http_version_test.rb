require 'test_helper'

module WebbedTest
  class HTTPVersionTest < TestCase
    test '#initialize with string' do
      version = Webbed::HTTPVersion.new('HTTP/1.1')
      assert_equal 1, version.major
      assert_equal 1, version.minor
    end
    
    test '#initialize with float' do
      version = Webbed::HTTPVersion.new(2.0)
      assert_equal 2, version.major
      assert_equal 0, version.minor
    end
    
    test '#to_s' do
      assert_equal 'HTTP/2.0', Webbed::HTTPVersion.new('HTTP/2.0').to_s
      assert_equal 'HTTP/2.0', Webbed::HTTPVersion.new(2.0).to_s
    end
    
    test '#to_f' do
      version = Webbed::HTTPVersion.new('HTTP/2.0')
      assert_equal 2.0, version.to_f
      
      version = Webbed::HTTPVersion.new(2.0)
      assert_equal 2.0, version.to_f
    end
    
    test 'comparisons' do
      one_point_one = Webbed::HTTPVersion.new('HTTP/1.1')
      two_point_oh1 = Webbed::HTTPVersion.new('HTTP/2.0')
      two_point_oh2 = Webbed::HTTPVersion.new('HTTP/2.0')
      
      assert_equal 1.1, one_point_one
      refute_equal 1.0, one_point_one
      assert_equal two_point_oh1, two_point_oh2
      
      assert_comparable one_point_one, two_point_oh1
    end
    
    test 'ONE_POINT_ONE' do
      assert_equal 1, Webbed::HTTPVersion::ONE_POINT_ONE.major
      assert_equal 1, Webbed::HTTPVersion::ONE_POINT_ONE.minor
    end
    
    test 'ONE_POINT_OH' do
      assert_equal 1, Webbed::HTTPVersion::ONE_POINT_OH.major
      assert_equal 0, Webbed::HTTPVersion::ONE_POINT_OH.minor
    end
  end
end