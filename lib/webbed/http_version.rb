module Webbed
  class HTTPVersion
    
    include Comparable
    REGEX = /^HTTP\/(\d+\.\d+)$/
    
    def self.new(http_version, dup = false)
      unless dup
        if ['HTTP/1.1', 1.1].include? http_version
          return ONE_POINT_ONE
        end
        
        if ['HTTP/1.0', 1.0].include? http_version
          return ONE_POINT_OH
        end
      end
      
      super(http_version)
    end
    
    def initialize(http_version)
      @http_version = to_f(http_version)
    end
    
    def to_s
      "HTTP/#{to_f}"
    end
    alias :inspect :to_s
    
    # This feels like a hack. Oh well.
    def to_f(http_version = @http_version)
      if http_version.respond_to? :match
        REGEX.match(http_version)[1].to_f
      else
        http_version.to_f
      end
    end
    
    def <=>(other_version)
      to_f <=> to_f(other_version)
    end
    
    def major
      to_f.floor
    end
    
    # TODO: Fix this ugly hack! :x
    def minor
      (to_f - to_f.floor).to_s[2..-1].to_i
    end
    
    ONE_POINT_ONE = HTTPVersion.new(1.1, true)
    ONE_POINT_OH = HTTPVersion.new(1.0, true)
  end
end