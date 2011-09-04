require 'test_helper'

module WebbedTest
  class CharsetTest < TestCase
    test 'string representation' do
      macedonian = Webbed::Charset.new('macedonian')
      assert_equal 'macedonian', macedonian.to_s
    end
    
    test 'equality' do
      macedonian0 = Webbed::Charset.new('macedonian')
      macedonian1 = Webbed::Charset.new('Macedonian')
      iso_ir_150 = Webbed::Charset.new('iso-ir-150')
      
      assert_equal macedonian1, macedonian0
      refute_equal macedonian0, iso_ir_150
    end
    
    test 'default quality' do
      macedonian = Webbed::Charset.new('macedonian')
      
      # These are the varios aliases for the ISO-8859-1 charset.
      iso_8859_1_1987 = Webbed::Charset.new('ISO_8859-1:1987')
      iso_ir_100 = Webbed::Charset.new('iso-ir-100')
      iso_8859_1 = Webbed::Charset.new('ISO_8859-1')
      iso_dash_8859_1 = Webbed::Charset.new('ISO-8859-1')
      latin1 = Webbed::Charset.new('latin1')
      l1 = Webbed::Charset.new('l1')
      ibm819 = Webbed::Charset.new('IBM819')
      cp819 = Webbed::Charset.new('CP819')
      csisolatin1 = Webbed::Charset.new('csISOLatin1')
      
      assert_equal 0, macedonian.default_quality
      assert_equal 1, iso_8859_1_1987.default_quality
      assert_equal 1, iso_ir_100.default_quality
      assert_equal 1, iso_8859_1.default_quality
      assert_equal 1, iso_dash_8859_1.default_quality
      assert_equal 1, latin1.default_quality
      assert_equal 1, l1.default_quality
      assert_equal 1, ibm819.default_quality
      assert_equal 1, cp819.default_quality
      assert_equal 1, csisolatin1.default_quality
    end
  end
end