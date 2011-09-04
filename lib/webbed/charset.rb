module Webbed
  class Charset
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
    
    # Returns the default quality of the charset.
    # 
    # For ISO-8859-1, this value is 1. For everything else, it's 0.
    # 
    # @return [0, 1]
    def default_quality
      iso_8859_1? ? 1 : 0
    end
    
    # Determines if the charset is a representation of ISO-8859-1.
    # 
    # @return [Boolean]
    def iso_8859_1?
      ISO_8859_1_ALIASES.include?(self)
    end
    
    # The canonical representation of the ISO-8859-1 charset.
    ISO_8859_1 = Webbed::Charset.new('ISO-8859-1')
    
    # All representations of the ISO-8859-1 charset.
    ISO_8859_1_ALIASES = [
      ISO_8859_1,
      Webbed::Charset.new('ISO_8859-1:1987'),
      Webbed::Charset.new('iso-ir-100'),
      Webbed::Charset.new('ISO_8859-1'),
      Webbed::Charset.new('latin1'),
      Webbed::Charset.new('l1'),
      Webbed::Charset.new('IBM819'),
      Webbed::Charset.new('CP819'),
      Webbed::Charset.new('csISOLatin1')
    ]
  end
end