require "webbed/error"

module Webbed
  # `UnkownMethod` is raised when an HTTP method in a request could not be
  # understood. This can be fixed by registering the method using
  # {Webbed::Method.register}.
  #
  # @author Alex Kern
  # @api public
  class UnknownMethod < Error
  end
end
