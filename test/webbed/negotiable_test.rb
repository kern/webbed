require 'test_helper'

module WebbedTest
  class NegotiableTest < TestCase
    def setup
      klass = Class.new do
        include Webbed::Negotiable
      end
      
      @negotiable = klass.new
    end
    
    test 'placeholder values' do
      assert_equal 0, @negotiable.precedence
      assert_equal 0, @negotiable.quality
      assert_equal 0, @negotiable.order
    end
    
    test '#precedence_sort_array' do
      @negotiable.instance_eval do
        def precedence; 3; end
        def quality; 0.5; end
        def order; 5; end
      end
      
      assert_equal [3, 0.5, -5], @negotiable.precedence_sort_array
    end
    
    test '#quality_sort_array' do
      @negotiable.instance_eval do
        def quality; 0.5; end
        def order; 5; end
      end
      
      assert_equal [0.5, -5], @negotiable.quality_sort_array
    end
  end
end 