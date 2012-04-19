module Webbed
  # `HTTPVersion` represents the HTTP version found in all HTTP messages.
  class HTTPVersion
    # Returns the major version.
    #
    # @return [Fixnum] the major version
    attr_reader :major

    # Returns the minor version.
    #
    # @return [Fixnum] the minor version
    attr_reader :minor

    # Parses an HTTP version from its string representation.
    #
    # @param [String] str the string representation of the HTTP version
    # @return [Webbed::HTTPVersion] the HTTP version parsed
    # @raise [Webbed::InvalidFormat] if the string representation was invalid
    def self.parse(str)
    end

    # Creates a new HTTP version.
    #
    # @param [Fixnum] major the major version
    # @param [Fixnum] minor the minor version
    def initialize(major, minor)
      @major = major
      @minor = minor
    end
  end
end
