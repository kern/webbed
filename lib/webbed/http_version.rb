module Webbed
  class HTTPVersion
    
    attr_reader :major, :minor
    REGEX = /^HTTP\/(\d+)\.(\d+)$/
    PREFIX = 'HTTP/'
    SEPARATOR = '.'
    
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
      if http_version.respond_to? :match
        # It's matchable
        http_version = REGEX.match http_version
        @major = http_version[1].to_i
        @minor = http_version[2].to_i
      else
        # It's a number
        @major = http_version.floor
        @minor = (http_version - @major).to_s[2..-1].to_i # TODO: Fix this ugly hack
      end
    end
    
    def to_s
      "#{PREFIX}#{major}#{SEPARATOR}#{minor}"
    end
    
    def to_f
      major + (minor.to_f / 10**minor.to_s.length) # TODO: Fix this ugly hack
    end
    
    def ==(other_version)
      if other_version.respond_to? :integer?
        # It's a number
        to_s == "#{PREFIX}#{other_version.to_f}"
      else
        # It's a string
        to_s == other_version.to_s
      end
    end
    
    ONE_POINT_ONE = HTTPVersion.new('HTTP/1.1', true)
    ONE_POINT_OH = HTTPVersion.new('HTTP/1.0', true)
  end
end