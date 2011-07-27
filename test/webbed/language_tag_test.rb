require 'test_helper'

module WebbedTest
  class LanguageTagTest < TestCase
    test '#to_s' do
      lang_range = Webbed::LanguageTag.new('en-gb')
      assert_equal 'en-gb', lang_range.to_s
    end
    
    test '#primary_tag' do
      lang_range = Webbed::LanguageTag.new('en-gb')
      assert_equal 'en', lang_range.primary_tag
    end
    
    test '#subtags' do
      cherokee = Webbed::LanguageTag.new('i-cherokee')
      assert_equal ['cherokee'], cherokee.subtags
      
      pig_latin = Webbed::LanguageTag.new('x-pig-latin')
      assert_equal ['pig', 'latin'], pig_latin.subtags
    end
  end
end