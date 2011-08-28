require 'test_helper'

module WebbedTest
  class MediaRangeTest < TestCase
    test 'inheritance' do
      media_range = Webbed::MediaRange.new('*/*')
      assert_kind_of Webbed::MediaType, media_range
    end
    
    test '#initialize with a global group' do
      media_range = Webbed::MediaRange.new('*/*')
      assert_equal '*/*', media_range.mime_type
      assert media_range.include?(Webbed::MediaType.new('foo/bar'))
    end
    
    test '#initialize with a type group' do
      media_range = Webbed::MediaRange.new('text/*')
      assert_equal 'text/*', media_range.mime_type
      assert media_range.include?(Webbed::MediaType.new('text/html'))
      refute media_range.include?(Webbed::MediaType.new('application/json'))
    end
    
    test '#initialize without a group' do
      media_range = Webbed::MediaRange.new('text/html')
      assert media_range.include?(Webbed::MediaType.new('text/html'))
      assert media_range.include?(Webbed::MediaType.new('text/html;level=1'))
      refute media_range.include?(Webbed::MediaType.new('text/xml'))
      refute media_range.include?(Webbed::MediaType.new('application/json'))
    end
    
    test '#initialize with parameters' do
      media_range = Webbed::MediaRange.new('text/html;q=1;level=1')
      assert media_range.include?(Webbed::MediaType.new('text/html;level=1'))
      refute media_range.include?(Webbed::MediaType.new('text/html;level=2'))
      refute media_range.include?(Webbed::MediaType.new('text/html'))
      refute media_range.include?(Webbed::MediaType.new('text/xml'))
      refute media_range.include?(Webbed::MediaType.new('application/json'))
    end
    
    test '#quality' do
      media_range = Webbed::MediaRange.new('text/html')
      assert_equal 1.0, media_range.quality
      
      media_range = Webbed::MediaRange.new('text/html; q=0.5')
      assert_equal 0.5, media_range.quality
      
      media_range.quality = 0.7
      assert_equal '0.7', media_range.parameters['q']
      assert_equal 0.7, media_range.quality
    end
    
    test '#accept_extensions' do
      media_range = Webbed::MediaRange.new('text/html; q=0.5')
      assert_equal({}, media_range.accept_extensions)
      
      media_range = Webbed::MediaRange.new('text/html; q=0.5; level=1')
      assert_equal({ 'level' => '1' }, media_range.accept_extensions)
    end
    
    test '#precedence' do
      media_range_global_group = Webbed::MediaRange.new('*/*')
      media_range_type_group = Webbed::MediaRange.new('text/*')
      media_range_zero_extensions = Webbed::MediaRange.new('text/html')
      media_range_one_extension = Webbed::MediaRange.new('text/html;level=1')
      media_range_suffixed_zero_extensions = Webbed::MediaRange.new('application/atom+xml')
      media_range_suffixed_one_extension = Webbed::MediaRange.new('application/atom+xml;level=1')
      
      assert_equal [0, 0], media_range_global_group.precedence
      assert_equal [1, 0], media_range_type_group.precedence
      assert_equal [2, 0], media_range_zero_extensions.precedence
      assert_equal [2, 1], media_range_one_extension.precedence
      assert_equal [3, 0], media_range_suffixed_zero_extensions.precedence
      assert_equal [3, 1], media_range_suffixed_one_extension.precedence
    end
    
    test '#to_s' do
      media_range_without_quality = Webbed::MediaRange.new('text/html; level=1')
      media_range_with_quality_1 = Webbed::MediaRange.new('text/html; q=1; level=1')
      media_range_with_quality_2 = Webbed::MediaRange.new('text/html; level=1; q=1')
      
      assert_equal 'text/html; level=1', media_range_without_quality.to_s
      assert_equal 'text/html; q=1; level=1', media_range_with_quality_1.to_s
      assert_equal 'text/html; q=1; level=1', media_range_with_quality_2.to_s
    end
  end
end