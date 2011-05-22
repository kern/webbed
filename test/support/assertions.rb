module WebbedTest
  module Assertions
    def assert_comparable(smaller, larger)
      assert_operator smaller, :<, larger
      assert_operator smaller, :<=, larger
      
      refute_operator larger, :<, smaller
      refute_operator larger, :<=, smaller
      
      assert_operator larger, :>, smaller
      assert_operator larger, :>=, smaller
      
      refute_operator smaller, :>, larger
      refute_operator smaller, :>=, larger
    end
  end
end