module Webbed
  # Webbed supports both primary versions of HTTP, HTTP/1.0 and HTTP/1.1.
  # Although the use of HTTP/1.1 has been strongly encouraged since its creation
  # in 1999, it remains relatively common for older command line tools (such as
  # wget) and some search engines. Webbed can also be extended in the future
  # to support new versions of HTTP, should one ever come into existence.
  # 
  # {Webbed::HTTPVersion} is a small abstraction on top of the HTTP-Version as
  # defined in RFC 2616. According to the RFC, its simple format is:
  # 
  #   HTTP-Version = "HTTP" "/" 1*DIGIT "." 1*DIGIT
  # 
  # While this is perhaps the simplest of all the abstractions in Webbed, it
  # does offer some nice helper methods for treating the version string more
  # Ruby-like.
  # 
  # HTTP/1.0 and HTTP/1.1 HTTPVersions are cached. In every case I can think of,
  # you will not have to create a new HTTPVersion, just use the constants
  # {Webbed::HTTPVersion::ONE_POINT_OH} and {Webbed::HTTPVersion::ONE_POINT_ONE}
  # when creating messages.
  # 
  # @author Alexander Kern
  class HTTPVersion
    
    include Comparable
    REGEX = /^HTTP\/(\d+\.\d+)$/
    
    # Creates a new HTTP-Version.
    # 
    # Only HTTP/1.0 and HTTP/1.1 versions are cached. All other versions will be
    # created at runtime each time this method is called.
    # 
    # @example
    #   Webbed::HTTPVersion.new(1.1)
    #   Webbed::HTTPVersion.new('HTTP/1.1')
    # 
    # @param [#match, #to_f] http_version The HTTP-Version to create
    # @return [Webbed::HTTPVersion] The new HTTPVersion
    def initialize(http_version)
      if http_version.respond_to? :match
        @http_version = http_version.match(REGEX)[1].to_f
      else
        @http_version = http_version.to_f
      end
    end
    
    # Stringifies according to RFC 2616.
    # 
    # @example
    #   version = Webbed::HTTPVersion.new(1.1)
    #   version.to_s # => 'HTTP/1.1'
    # 
    # @return [String] The stringified HTTP-Version
    def to_s
      "HTTP/#{to_f}"
    end
    alias :inspect :to_s
    
    # Float-ifies!
    # 
    # @example
    #   version = Webbed::HTTPVersion.new('HTTP/1.1')
    #   version.to_f # => 1.1
    # 
    # @return [Float] The float-ified HTTP-Version
    def to_f
      @http_version
    end
    
    # Compare to another HTTP-Version.
    # 
    # You'll rarely directly use this method. It does, however, allow you to use
    # all the fun little things that the Comparable has to offer. This includes
    # checking for equality and sorting. Fun fun fun!
    # 
    # @param [#to_f] other The other HTTP-Version to compare against
    # 
    # @example
    #   version_1_1 = Webbed::HTTPVersion.new(1.1)
    #   version_5_0 = Webbed::HTTPVersion.new('HTTP/5.0')
    #   version_1_1 == version_5_0 # => false
    #   version_5_0 < version_5_0 # => false
    #   version_5_0 > version_1_1 # => true
    def <=>(other)
      to_f <=> other.to_f
    end
    
    # Major HTTP-Version number as an integer.
    # 
    # @example
    #   version = Webbed::HTTPVersion.new('HTTP/6.9')
    #   version.major # => 6
    # 
    # @return [Fixnum] Major HTTP-Version number
    def major
      to_f.floor
    end
    
    # Minor HTTP-Version number as an integer.
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
    # @return [Fixnum] Minor HTTP-Version number
    def minor
      to_f.to_s.split('.')[1].to_i
    end
    
    ONE_POINT_ONE = HTTPVersion.new(1.1)
    ONE_POINT_OH = HTTPVersion.new(1.0)
  end
end