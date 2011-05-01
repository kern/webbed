module Webbed
  # Webbed supports both primary versions of HTTP, HTTP/1.0 and HTTP/1.1.
  # Although the use of HTTP/1.1 has been strongly encouraged since its creation
  # in 1999, it remains relatively common for older command line tools (such as
  # wget) and some search engines. Webbed can also be extended in the future to
  # support new versions of HTTP, should one ever come into existence.
  # 
  # {HTTPVersion} is a small abstraction on top of the HTTP-Version as defined
  # in RFC 2616. According to the RFC, its simple format is:
  # 
  #     HTTP-Version = "HTTP" "/" 1*DIGIT "." 1*DIGIT
  # 
  # While this is perhaps the simplest of all the abstractions in Webbed, it
  # does offer some nice helper methods for treating the version string more
  # Ruby-like.
  # 
  # HTTP/1.0 and HTTP/1.1 {HTTPVersion}'s are cached. In every case I can think
  # of, you will not have to create a new {HTTPVersion}, just use the constants
  # {ONE_POINT_OH} and {ONE_POINT_ONE} when creating messages.
  class HTTPVersion
    include Comparable
    
    # Regular expression for retrieving the major and minor version numbers from
    # an HTTP-Version
    REGEX = /^HTTP\/(\d+)\.(\d+)$/
    
    # Creates a new HTTP-Version
    # 
    # Only HTTP/1.0 and HTTP/1.1 versions are cached. All other versions will be
    # created at runtime each time this method is called.
    # 
    # @example
    #   Webbed::HTTPVersion.new(1.1)
    #   Webbed::HTTPVersion.new('HTTP/1.1')
    # 
    # @param http_version [#to_s] the HTTP-Version to create
    def initialize(http_version)
      if REGEX =~ http_version.to_s
        @http_version = http_version.to_s
      else
        @http_version = "HTTP/#{http_version}"
      end
    end
    
    # Converts the HTTP-Version to a string according to RFC 2616
    # 
    # @example
    #   version = Webbed::HTTPVersion.new(1.1)
    #   version.to_s # => 'HTTP/1.1'
    # 
    # @return [String]
    def to_s
      @http_version
    end
    
    # Converts the HTTP-Version to a float
    # 
    # @example
    #   version = Webbed::HTTPVersion.new('HTTP/1.1')
    #   version.to_f # => 1.1
    # 
    # @return [Float]
    def to_f
      REGEX =~ @http_version
      "#{$1}.#{$2}".to_f
    end
    
    # Compares the HTTP-Version to another HTTP-Version
    # 
    # @example
    #   version_1_1 = Webbed::HTTPVersion.new(1.1)
    #   version_5_0 = Webbed::HTTPVersion.new('HTTP/5.0')
    #   version_1_1 == version_5_0 # => false
    #   version_5_0 < version_5_0 # => false
    #   version_5_0 > version_1_1 # => true
    # 
    # @param other_http_version [#to_f] the other HTTP-Version
    # @return [Fixnum] the sign of the comparison (either `1`, `0`, or `-1`)
    def <=>(other_http_version)
      to_f <=> other_http_version.to_f
    end
    
    # The major HTTP-Version number
    # 
    # @example
    #   version = Webbed::HTTPVersion.new('HTTP/6.9')
    #   version.major # => 6
    # 
    # @return [Fixnum]
    def major
      REGEX =~ @http_version
      $1.to_i
    end
    
    # The minor HTTP-Version number
    # 
    # @example
    #   version = Webbed::HTTPVersion.new('HTTP/4.2')
    #   version.minor # => 2
    # 
    # @return [Fixnum]
    def minor
      REGEX =~ @http_version
      $2.to_i
    end
    
    # HTTP/1.1
    ONE_POINT_ONE = HTTPVersion.new(1.1)
    
    # HTTP/1.0
    ONE_POINT_OH = HTTPVersion.new(1.0)
  end
end