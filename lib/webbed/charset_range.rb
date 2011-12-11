module Webbed
  # TODO: Document this class.
  class CharsetRange
    include Webbed::Negotiable
    attr_accessor :range
    attr_writer :quality
    
    def self.parse(string)
      parser = Webbed::Grammars::CharsetRangeParser.new
      parser.parse(string).value
    end
    
    def initialize(range, options = {})
      @range = range
      @quality = options[:quality]
    end
    
    def star?
      @range == '*'
    end
    
    def quality
      @quality ? @quality.to_f : 1.0
    end
    
    def to_s
      @quality ? "#{@range}; q=#{@quality}" : @range
    end
    
    def precedence
      star? ? 0 : 1
    end
    
    def include?(charset)
      star? || @range == charset.to_s
    end
  end
end