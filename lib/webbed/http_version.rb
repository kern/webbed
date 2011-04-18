module Webbed
  # {Webbed} supports both primary versions of HTTP, HTTP/1.0 and HTTP/1.1.
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
  # While this is perhaps the simplest of all the abstractions in {Webbed}, it
  # does offer some nice helper methods for treating the version string more
  # Ruby-like.
  # 
  # HTTP/1.0 and HTTP/1.1 {HTTPVersion}'s are cached. In every case I can think
  # of, you will not have to create a new {HTTPVersion}, just use the constants
  # {ONE_POINT_OH} and {ONE_POINT_ONE} when creating messages.
  class HTTPVersion
    include Comparable
    REGEX = /^HTTP\/(\d+\.\d+)$/
    
    # Creates a new {HTTPVersion}.
    # 
    # Only HTTP/1.0 and HTTP/1.1 versions are cached. All other versions will be
    # created at runtime each time this method is called.
    # 
    # @example
    #   Webbed::HTTPVersion.new(1.1)
    #   Webbed::HTTPVersion.new('HTTP/1.1')
    # 
    # @param http_version [#match, #to_f] the {HTTPVersion} to create
    # @return [HTTPVersion] the new {HTTPVersion}
    def initialize(http_version)
      if REGEX =~ http_version.to_s
        @http_version = $1.to_f
      else
        @http_version = http_version.to_f
      end
    end
    
    # Converts to a string according to RFC 2616.
    # 
    # @example
    #   version = Webbed::HTTPVersion.new(1.1)
    #   version.to_s # => 'HTTP/1.1'
    # 
    # @return [String] the string {HTTPVersion}
    def to_s
      "HTTP/#{to_f}"
    end
    
    # Converts to a float.
    # 
    # @example
    #   version = Webbed::HTTPVersion.new('HTTP/1.1')
    #   version.to_f # => 1.1
    # 
    # @return [Float] the float {HTTPVersion}
    def to_f
      @http_version
    end
    
    # Compares to another {HTTPVersion}.
    # 
    # @example
    #   version_1_1 = Webbed::HTTPVersion.new(1.1)
    #   version_5_0 = Webbed::HTTPVersion.new('HTTP/5.0')
    #   version_1_1 == version_5_0 # => false
    #   version_5_0 < version_5_0 # => false
    #   version_5_0 > version_1_1 # => true
    # 
    # @param other [#to_f] the other {HTTPVersion} to compare against
    # @return [Integer] the sign of the comparison (either `1`, `0`, or `-1`)
    def <=>(other)
      to_f <=> other.to_f
    end
    
    # Returns the major HTTP-Version number as an integer.
    # 
    # @example
    #   version = Webbed::HTTPVersion.new('HTTP/6.9')
    #   version.major # => 6
    # 
    # @return [Fixnum] major HTTP-Version number
    def major
      to_f.floor
    end
    
    # Return the minor HTTP-Version number as an integer.
    # 
    # Right now this is a pretty big hack since the HTTP-Version is internally
    # stored as a float. Ruby does not natively offer a way to get the string of
    # numbers after a decimal, so a workaround had to be created.
    # 
    # If anyone knows of a better way to do this, please oh please contact me on
    # GitHub.
    # 
    # @example
    #   version = Webbed::HTTPVersion.new('HTTP/4.2')
    #   version.minor # => 2
    # 
    # @return [Fixnum] minor HTTP-Version number
    def minor
      to_f.to_s.split('.')[1].to_i
    end
    
    # HTTP/1.1
    ONE_POINT_ONE = HTTPVersion.new(1.1)
    
    # HTTP/1.0
    ONE_POINT_OH = HTTPVersion.new(1.0)
  end
end