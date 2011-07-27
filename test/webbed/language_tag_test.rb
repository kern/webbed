require 'test_helper'

module WebbedTest
  class LanguageTagTest < TestCase
    test '#tags' do
      lang_range = Webbed::LanguageTag.new('en-us')
      assert_equal ['en', 'us'], lang_range.tags
      assert_equal 'en-us', lang_range.to_s
      
      lang_range.tags = ['rs', 'gb']
      assert_equal ['rs', 'gb'], lang_range.tags
      assert_equal 'rs-gb', lang_range.to_s
    end
    
    test '#primary_tag' do
      lang_range = Webbed::LanguageTag.new('en-gb')
      assert_equal 'en', lang_range.primary_tag
      assert_equal 'en-gb', lang_range.to_s
      
      lang_range.primary_tag = 'rs'
      assert_equal 'rs', lang_range.primary_tag
      assert_equal 'rs-gb', lang_range.to_s
    end
    
    test '#subtags' do
      cherokee = Webbed::LanguageTag.new('i-cherokee')
      assert_equal ['cherokee'], cherokee.subtags
      assert_equal 'i-cherokee', cherokee.to_s
      
      cherokee.subtags = ['roflcopter']
      assert_equal ['roflcopter'], cherokee.subtags
      assert_equal 'i-roflcopter', cherokee.to_s
            
      pig_latin = Webbed::LanguageTag.new('x-pig-latin')
      assert_equal ['pig', 'latin'], pig_latin.subtags
      assert_equal 'x-pig-latin', pig_latin.to_s
      
      pig_latin.subtags = ['roflcopter', 'lol']
      assert_equal ['roflcopter', 'lol'], pig_latin.subtags
      assert_equal 'x-roflcopter-lol', pig_latin.to_s
    end
  end
end