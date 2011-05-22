require 'test_helper'

module WebbedTest
  module HelperTest
    class SchemeHelperTest < TestCase
      test 'HTTP scheme' do
        request = Webbed::Request.new('GET', '*', {}, '', :scheme => 'http')
        
        refute request.secure?
        assert_equal 80, request.default_port
      end
      
      test 'HTTPS scheme' do
        request = Webbed::Request.new('GET', '*', {}, '', :scheme => 'https')
        
        assert request.secure?
        assert_equal 443, request.default_port
      end
      
      test 'unknown scheme' do
        request = Webbed::Request.new('GET', '*', {}, '', :scheme => 'foo')
        
        refute request.secure?
        assert_nil request.default_port
      end
    end
  end
end