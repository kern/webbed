module Webbed
  # TODO: Document this class.
  class CharsetRange
    include Webbed::Negotiable
    
    Q_REGEX = /(?:\s*;\s*q\s*=\s*(.*))?/
    CHARSET_RANGE_REGEX = /(\*|[-\w.+]+)#{Q_REGEX}/
    
    attr_accessor :order
    
    def initialize(string, options = {})
      string =~ CHARSET_RANGE_REGEX
      @charset = $1
      @quality = $2
      @order = options.fetch(:order, 0)
    end
    
    def star?
      @charset == '*'
    end
    
    def quality=(quality)
      @quality = quality.to_s
    end
    
    def quality
      @quality ? @quality.to_f : 1.0
    end
    
    def to_s
      @quality ? "#{@charset}; q=#{@quality}" : @charset
    end
    
    def precedence
      star? ? 0 : 1
    end
    
    def include?(charset)
      star? || @charset == charset.to_s
    end
  end
end