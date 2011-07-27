module Webbed
  # Representation of an HTTP language tag.
  class LanguageTag
    TAG_REGEX = /[A-Za-z]{1,8}/
    REGEX = /(#{TAG_REGEX})((?:-#{TAG_REGEX})*)/
    
    # Creates a new language tag.
    # 
    # @param [String] tag
    def initialize(tag)
      @tag = tag
    end
    
    # Converts the language tag to a String.
    # 
    # @return [String]
    def to_s
      @tag
    end
    
    # The primary-tag of the language tag.
    # 
    # The primary-tag is the part of the language tag before the first dash.
    # If there is no dash, the entire language tag is the primary-tag.
    # 
    # @return [String]
    def primary_tag
      @tag =~ REGEX
      $1
    end
    
    # The subtags of the language tag.
    # 
    # The subtags are all of the parts of the language tag after the first dash,
    # each separated by dashes.
    # 
    # @return [<String>]
    def subtags
      @tag =~ REGEX
      $2.split('-').reject { |t| t.empty? }
    end
  end
end