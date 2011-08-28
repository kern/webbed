require 'test_helper'

module WebbedTest
  class ContentNegotiatorTest < TestCase
    def setup
      @en_gb = Webbed::LanguageTag.new('en-gb')
      @en_us = Webbed::LanguageTag.new('en-us')
    end
    
    test '#negotiate with no accepted tags' do
      negotiator = create_negotiator('en-gb', 'x-pig-latin; q=0.2')
      assert_nil negotiator.negotiate([])
    end
    
    test '#negotiate with the only tag matching the only range' do
      negotiator = create_negotiator('en-gb')
      assert_equal @en_gb, negotiator.negotiate([@en_gb])
    end
    
    test '#negotiate with the only tag matching the second range' do
      negotiator = create_negotiator('x-pig-latin; q=0.2', 'en-gb')
      assert_equal @en_gb, negotiator.negotiate([@en_gb])
    end
    
    test '#negotiate with the second tag matching the only range' do
      negotiator = create_negotiator('en-gb')
      assert_equal @en_gb, negotiator.negotiate([@en_us, @en_gb])
    end
    
    test '#negotiate with the second tag matching the second range' do
      negotiator = create_negotiator('x-pig-latin; q=0.2', 'en-gb')
      assert_equal @en_gb, negotiator.negotiate([@en_us, @en_gb])
    end
    
    test '#negotiate with both tags matching the only range' do
      negotiator = create_negotiator('*; q=0.5')
      assert_equal @en_us, negotiator.negotiate([@en_us, @en_gb])
      assert_equal @en_gb, negotiator.negotiate([@en_gb, @en_us])
    end
    
    test '#negotiate with varying qualities' do
      negotiator = create_negotiator('en-gb', 'en-us; q=0.2')
      assert_equal @en_gb, negotiator.negotiate([@en_gb, @en_us])
      assert_equal @en_gb, negotiator.negotiate([@en_us, @en_gb])
      
      negotiator = create_negotiator('en-gb; q=0.2', 'en-us')
      assert_equal @en_us, negotiator.negotiate([@en_gb, @en_us])
      assert_equal @en_us, negotiator.negotiate([@en_us, @en_gb])
      
      negotiator = create_negotiator('en-gb', 'en-us')
      assert_equal @en_gb, negotiator.negotiate([@en_gb, @en_us])
      assert_equal @en_gb, negotiator.negotiate([@en_us, @en_gb])
    end
    
    test '#negotiate with a quality of 0 on a specific range' do
      negotiator = create_negotiator('en-gb; q=0', '*')
      assert_nil negotiator.negotiate([@en_gb])
      assert_equal @en_us, negotiator.negotiate([@en_gb, @en_us])
      assert_equal @en_us, negotiator.negotiate([@en_us, @en_gb])
    end
    
    test '#negotiate with varying precedences' do
      negotiator = create_negotiator('en-gb', '*')
      assert_equal @en_gb, negotiator.negotiate([@en_gb, @en_us])
      assert_equal @en_gb, negotiator.negotiate([@en_us, @en_gb])
      assert_equal @en_us, negotiator.negotiate([@en_us])
      
      negotiator = create_negotiator('*', 'en-gb')
      assert_equal @en_us, negotiator.negotiate([@en_gb, @en_us])
      assert_equal @en_us, negotiator.negotiate([@en_us, @en_gb])
      assert_equal @en_us, negotiator.negotiate([@en_us])
    end
    
    test '#negotiate with ranges of equal precedence and quality' do
      negotiator = create_negotiator('en-gb', 'en-us')
      assert_equal @en_gb, negotiator.negotiate([@en_gb, @en_us])
      assert_equal @en_gb, negotiator.negotiate([@en_us, @en_gb])
      
      negotiator = create_negotiator('en-us', 'en-gb')
      assert_equal @en_us, negotiator.negotiate([@en_gb, @en_us])
      assert_equal @en_us, negotiator.negotiate([@en_us, @en_gb])
    end
    
    def create_negotiator(*range_strings)
      ranges = range_strings.each_with_index.map do |range, index|
        Webbed::LanguageRange.new(range, :order => index)
      end
      
      Webbed::ContentNegotiator.new(ranges)
    end
  end
end