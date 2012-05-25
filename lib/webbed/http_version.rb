require "webbed/grammars/interpreter"
require "webbed/grammars/http_version_parser"
require "webbed/grammars/http_version_transform"

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
    attr_reader :major_version

    # Returns the minor version.
    #
    # @return [Fixnum]
    attr_reader :minor_version

    # Interprets an HTTP version.
    #
    # @param [String] string the string representation of the HTTP version
    # @param [Grammars::Interpreter] interpreter the interpreter to use
    # @return [HTTPVersion] the interpreted HTTP version
    # @raise [InvalidFormat] if the string representation was invalid
    def self.interpret(string, interpreter = Grammars::Interpreter.new(Grammars::HTTPVersionParser.new, Grammars::HTTPVersionTransform.new))
      interpreter.interpret(string)
    end

    # Creates a new HTTP version.
    #
    # @param [Fixnum] major_version the major version
    # @param [Fixnum] minor_version the minor version
    def initialize(major_version, minor_version)
      @major_version = major_version
      @minor_version = minor_version
    end

    # Compares two HTTP versions.
    #
    # @param [HTTPVersion] other
    # @return [-1, 0, 1, nil]
    def <=>(other)
      [major_version, minor_version] <=> [other.major_version, other.minor_version]
    rescue NoMethodError
      nil
    end

    # HTTP/1.1
    ONE_POINT_ONE = new(1, 1)

    # HTTP/1.0
    ONE_POINT_OH = new(1, 0)
  end
end
