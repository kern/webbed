module Webbed
  # Representation of an HTTP language range.
  class LanguageRange < LanguageTag
    # The quality of the language range.
    # 
    # @return [Fixnum]
    attr_reader :quality
    
    # The order of the language range.
    # 
    # @return [Fixnum]
    attr_accessor :order
    
    Q_REGEX = /(?:\s*;\s*q\s*=\s*(.*))?/
    STAR_REGEX = /(\*)#{Q_REGEX}/
    TAG_REGEX = /[a-zA-Z]{0,8}/
    LANGUAGE_TAG_REGEX = /(#{TAG_REGEX}(?:-#{TAG_REGEX})*)#{Q_REGEX}/
    
    # Creates a new language range.
    # 
    # @param [String] tag
    # @param [Hash] options the options to create the language range with
    # @option options [Fixnum] :order (0) the order of the language range
    def initialize(string, options = {})
      STAR_REGEX =~ string || LANGUAGE_TAG_REGEX =~ string
      super($1)
      @quality = $2
      @order = options.fetch(:order, 0)
    end
    
    # Whether or not the language range is a catch-all.
    # 
    # @return [Boolean]
    def star?
      primary_tag == '*'
    end
    
    # The quality of the language range.
    # 
    # @return [Float]
    def quality
      @quality ? @quality.to_f : 1.0
    end
    
    # Sets the quality of the language range.
    # 
    # @param [#to_s] quality
    def quality=(quality)
      @quality = quality.to_s
    end
    
    # Converts the language range to a String.
    # 
    # @return [String]
    def to_s
      @quality ? "#{super}; q=#{@quality}" : super
    end
    
    # The range of the language range.
    # 
    # @return [String]
    def range
      tags.join('-')
    end
    
    # Whether or not the language tag is in the language range.
    # 
    # @param [Webbed::LanguageTag] language_tag
    # @return [Boolean]
    def include?(language_tag)
      star? || tags == language_tag.tags[0, tags.size]
    end
    
    # The level of specificity of the language range.
    # 
    # @return [Fixnum]
    def specificity
      star? ? 0 : range.size
    end
    
    # Compares the Language Range to another Language Range.
    # 
    # It sorts Language Ranges by quality and order, in that order.
    # 
    # @param [Webbed::LanguageRange] other
    def <=>(other)
      [quality, other.order] <=> [other.quality, order]
    end
  end
end