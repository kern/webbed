require "webbed/grammars/loader"
Webbed::Grammars::Loader.require("http_version")

module Webbed
  # `HTTPVersion` represents the HTTP version found in all HTTP messages.
  #
  # @author Alex Kern
  # @api public
  class HTTPVersion
    include Comparable

    # Returns the major version.
    #
    # @return [Fixnum]
    attr_reader :major

    # Returns the minor version.
    #
    # @return [Fixnum]
    attr_reader :minor

    # Parses an HTTP version from its string representation.
    #
    # @param [String] str the string representation of the HTTP version
    # @param [Webbed::Grammars::HTTPVersionParser] parser the parser to use
    # @return [Webbed::HTTPVersion] the HTTP version parsed
    # @raise [Webbed::InvalidFormat] if the string representation was invalid
    def self.parse(str, parser = Grammars::HTTPVersionParser.new)
      node = parser.parse(str)
      new(node.major, node.minor)
    end

    # Creates a new HTTP version.
    #
    # @param [Fixnum] major the major version
    # @param [Fixnum] minor the minor version
    def initialize(major, minor)
      @major = major
      @minor = minor
    end

    # Compares two HTTP versions.
    #
    # @param [Webbed::HTTPVersion] other
    # @return [-1, 0, 1, nil]
    def <=>(other)
      [major, minor] <=> [other.major, other.minor]
    rescue NoMethodError
      nil
    end

    # HTTP/1.1
    ONE_POINT_ONE = new(1, 1)

    # HTTP/1.0
    ONE_POINT_OH = new(1, 0)
  end
end
