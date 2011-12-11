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
  end
end