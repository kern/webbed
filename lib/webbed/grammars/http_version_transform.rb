require "webbed/grammars/transform"
require "webbed/http_version"

module Webbed
  module Grammars
    class HTTPVersionTransform < Transform
      context http_version_builder: HTTPVersion.method(:new)

      rule(major_version: simple(:major_version), minor_version: simple(:minor_version)) do
        http_version_builder.call(major_version.to_i, minor_version.to_i)
      end
    end
  end
end
