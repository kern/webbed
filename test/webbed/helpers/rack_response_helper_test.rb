require 'test_helper'

module WebbedTest
  module HelperTest
    class RackResponseHelperTest < TestCase
      test '#to_rack' do
        response = Webbed::Response.new(200, {}, '')
        
        if ''.respond_to?(:each)
          assert_equal [200, {}, ''], response.to_rack
        else
          assert_equal [200, {}, ['']], response.to_rack
        end
        
        string_io = StringIO.new
        response = Webbed::Response.new(200, {}, string_io)
        assert_equal [200, {}, string_io], response.to_rack
      end
      
      test '#to_a' do
        response = Webbed::Response.new(200, {}, '')
        assert_equal ['200 OK', {}, ''], response.to_a
      end
    end
  end
end