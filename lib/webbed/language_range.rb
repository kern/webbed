module Webbed
  # Representation of an HTTP language range.
  class LanguageRange
    # The quality of the language range.
    # 
    # @return [Fixnum]
    attr_reader :quality
    
    # The range of the language range.
    # 
    # @return [String]
    attr_reader :range
    
    Q_REGEX = /(?:\s*;\s*q\s*=\s*(.*))?/
    STAR_REGEX = /(\*)#{Q_REGEX}/
    TAG_REGEX = /[A-Za-z]{1,8}/
    LANGUAGE_TAG_REGEX = /((#{TAG_REGEX})((?:-#{TAG_REGEX})*))#{Q_REGEX}/
    
    # (see Webbed::LanguageTag#initialize)
    def initialize(string)
      STAR_REGEX =~ string || LANGUAGE_TAG_REGEX =~ string
      @string = string
      @range = $1
      @quality = $2
    end
    
    # Whether or not the language range is a catch-all.
    # 
    # @return [Boolean]
    def star?
      @range == '*'
    end
    
    # Converts the language range to a String.
    # 
    # @return [String]
    def to_s
      @string
    end
    
    # (see Webbed::LanguageTag#primary_tag)
    def primary_tag
      if star?
        '*'
      else
        @range =~ LANGUAGE_TAG_REGEX
        $2
      end
    end
    
    # (see Webbed::LanguageTag#subtags)
    def subtags
      if star?
        nil
      else
        @range =~ LANGUAGE_TAG_REGEX
        $3.split('-').reject { |t| t.empty? }
      end
    end
  end
end