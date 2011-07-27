require 'test_helper'

module WebbedTest
  class LanguageRangeTest < TestCase
    test '#range' do
      star = Webbed::LanguageRange.new('*')
      assert_equal '*', star.range
      
      star_with_q = Webbed::LanguageRange.new('*;q=5')
      assert_equal '*', star_with_q.range
      
      other = Webbed::LanguageRange.new('en-gb')
      assert_equal 'en-gb', other.range
      
      other_with_q = Webbed::LanguageRange.new('en-gb;q=99')
      assert_equal 'en-gb', other_with_q.range
    end
    
    test '#star?' do
      star = Webbed::LanguageRange.new('*')
      assert star.star?
      
      other = Webbed::LanguageRange.new('en-gb')
      refute other.star?
    end
    
    test '#to_s' do
      star = Webbed::LanguageRange.new('*')
      assert_equal '*', star.to_s
      
      other = Webbed::LanguageRange.new('en-gb;q=99')
      assert_equal 'en-gb;q=99', other.to_s
    end
    
    test '#primary_tag' do
      star = Webbed::LanguageRange.new('*')
      assert_equal '*', star.primary_tag
      
      other = Webbed::LanguageRange.new('en-gb')
      assert_equal 'en', other.primary_tag
    end
    
    test '#subtags' do
      star = Webbed::LanguageRange.new('*')
      assert_nil star.subtags
      
      other = Webbed::LanguageRange.new('en-gb')
      assert_equal ['gb'], other.subtags
    end
  end
end