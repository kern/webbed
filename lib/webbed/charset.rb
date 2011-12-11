module Webbed
  class Charset
    def self.parse(string)
      parser = Webbed::Grammars::CharsetParser.new
      parser.parse(string).value
    end
    
    # Creates a new charset.
    # 
    # @param [String] string the string that the charset represents
    def initialize(string)
      @string = string
    end
    
    # @return [String] the string representation of the charset
    def to_s
      @string
    end
    
    # Determines if two charsets are equal.
    # 
    # The only identifying characteristic of charsets are the string they
    # represent. The check is case-insensitive.
    # 
    # @param [#to_s] other the other charset
    # @return [Boolean]
    def ==(other)
      @string.downcase == other.to_s.downcase
    end
  end
end