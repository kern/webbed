require "webbed/grammars/transform"
require "webbed/http_version"

module Webbed
  module Grammars
    # `HTTPVersionTransform` transforms a hash of a major and minor version of
    # an HTTP version into an actual HTTP version.
    #
    # @author Alexander Simon Kern (alex@kernul)
    # @api private
    class HTTPVersionTransform < Transform
      context do
        {
          http_version_builder: HTTPVersion.method(:new)
        }
      end

      rule(major_version: simple(:major_version), minor_version: simple(:minor_version)) do
        http_version_builder.call(major_version.to_i, minor_version.to_i)
      end
    end
  end
end
