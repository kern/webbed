module Webbed
  # Representation of an HTTP Version.
  #
  # TODO: Document this class.
  class HTTPVersion
    include Comparable

    # Returns the major version number.
    #
    # @return [Fixnum]
    attr_reader :major

    # Returns the minor version number.
    #
    # @return [Fixnum]
    attr_reader :minor

    # Creates a new HTTP Version.
    #
    # @param [String] str the string representation of the HTTP Version
    def initialize(str)
      parser = Webbed::Grammars::HTTPVersionParser.new
      result = parser.parse(str)

      if result
        @major = result.value[0]
        @minor = result.value[1]
      else
        raise ParseError.new("Invalid HTTP Version.")
      end
    end

    # Converts the HTTP Version to a string.
    #
    # @return [String]
    def to_s
      "HTTP/#{major}.#{minor}"
    end

    # Converts the HTTP Version to an array.
    #
    # @return [<Fixnum>]
    def to_a
      [major, minor]
    end

    # Compares the HTTP Version to another HTTP Version.
    #
    # @param [Webbed::HTTPVersion] other
    # @return [Fixnum]
    def <=>(other)
      to_a <=> other.to_a
    end

    ONE_POINT_ONE = new("HTTP/1.1")
    ONE_POINT_OH = new("HTTP/1.0")
  end
end
