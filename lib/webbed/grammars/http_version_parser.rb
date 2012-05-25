require "parslet"
require "webbed/grammars/core_rules"

module Webbed
  module Grammars
    class HTTPVersionParser < Parslet::Parser
      include CoreRules

      rule(:http_version) { http_name >> str("/") >> digit.as(:major_version) >> str(".") >> digit.as(:minor_version) }
      rule(:http_name) { str("HTTP") }
      root(:http_version)
    end
  end
end
