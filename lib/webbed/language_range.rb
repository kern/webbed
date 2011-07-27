module Webbed
  # Representation of an HTTP language range.
  class LanguageRange < LanguageTag
    # The quality of the language range.
    # 
    # @return [Fixnum]
    attr_reader :quality
    
    Q_REGEX = /(?:\s*;\s*q\s*=\s*(.*))?/
    STAR_REGEX = /(\*)#{Q_REGEX}/
    LANGUAGE_TAG_REGEX = /((#{TAG_REGEX})((?:-#{TAG_REGEX})*))#{Q_REGEX}/
    
    # (see Webbed::LanguageTag#initialize)
    def initialize(string)
      STAR_REGEX =~ string || LANGUAGE_TAG_REGEX =~ string
      @string = string
      @tag = $1
      @quality = $2
    end
    
    # Whether or not the language range is a catch-all.
    # 
    # @return [Boolean]
    def star?
      @tag == '*'
    end
    
    # Converts the language range to a String.
    # 
    # @return [String]
    def to_s
      @string
    end
    
    # The range of the language range.
    # 
    # @return [String]
    def range
      @tag
    end
    
    # (see Webbed::LanguageTag#primary_tag)
    def primary_tag
      star? ? '*' : super
    end
    
    # (see Webbed::LanguageTag#subtags)
    def subtags
      star? ? nil : super
    end
  end
end