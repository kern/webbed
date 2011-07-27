module Webbed
  # Representation of an HTTP language tag.
  class LanguageTag
    # The tags of the language tag.
    # 
    # @return [<String>]
    attr_accessor :tags
    
    # Creates a new language tag.
    # 
    # @param [String] tag
    def initialize(tag)
      self.tags = tag.split('-')
    end
    
    # Converts the language tag to a String.
    # 
    # @return [String]
    def to_s
      tags.join('-')
    end
    
    # The primary-tag of the language tag.
    # 
    # The primary-tag is the part of the language tag before the first dash.
    # If there is no dash, the entire language tag is the primary-tag.
    # 
    # @return [String]
    def primary_tag
      tags[0]
    end
    
    # Set the primary-tag of the language tag.
    # 
    # @param [String] primary_tag
    def primary_tag=(primary_tag)
      tags[0] = primary_tag
    end
    
    # The subtags of the language tag.
    # 
    # The subtags are all of the parts of the language tag after the first dash,
    # each separated by dashes.
    # 
    # @return [<String>]
    def subtags
      tags[1, tags.size - 1]
    end
    
    # The subtags of the language tag.
    # 
    # @param [<String>] subtags
    def subtags=(subtags)
      tags[1, tags.size - 1] = subtags
    end
  end
end