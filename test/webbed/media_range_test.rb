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
  end
end