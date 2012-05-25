require "parslet"

module Webbed
  module Grammars
    class HTTPVersionTransform < Parslet::Transform
      rule(major_version: simple(:major_version), minor_version: simple(:minor_version)) do
        HTTPVersion.new(major_version.to_i, minor_version.to_i)
      end
    end
  end
end
