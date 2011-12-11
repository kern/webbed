require 'test_helper'

module WebbedTest
  class CharsetRangeTest < TestCase
    test 'parse' do
      macedonian = Webbed::CharsetRange.parse('macedonian; q=0.5')
      assert_equal 'macedonian', macedonian.range
      assert_equal 0.5, macedonian.quality
    end
    
    test 'star' do
      star = Webbed::CharsetRange.new('*')
      macedonian = Webbed::CharsetRange.new('macedonian')
      
      assert star.star?
      refute macedonian.star?
    end
    
    test 'quality' do
      macedonian0 = Webbed::CharsetRange.new('macedonian')
      macedonian1 = Webbed::CharsetRange.new('macedonian', :quality => 0.2)
      
      assert_equal 1, macedonian0.quality
      assert_equal 0.2, macedonian1.quality
      
      macedonian0.quality = 0.5
      assert_equal 0.5, macedonian0.quality
      assert_equal 'macedonian; q=0.5', macedonian0.to_s
    end
    
    test 'precedence' do
      star = Webbed::CharsetRange.new('*')
      iso_8859_1 = Webbed::CharsetRange.new('ISO-8859-1')
      macedonian = Webbed::CharsetRange.new('macedonian')
      
      assert_equal 0, star.precedence
      assert_equal 1, iso_8859_1.precedence
      assert_equal 1, macedonian.precedence
    end
    
    test 'including charsets' do
      star = Webbed::CharsetRange.new('*')
      macedonia_range = Webbed::CharsetRange.new('macedonia')
      macedonia_charset = Webbed::Charset.new('macedonia')
      iso_8859_1_charset = Webbed::Charset.new('ISO-8859-1')
      
      assert_includes star, macedonia_charset
      assert_includes star, iso_8859_1_charset
      
      assert_includes macedonia_range, macedonia_charset
      refute_includes macedonia_range, iso_8859_1_charset
    end
  end
end