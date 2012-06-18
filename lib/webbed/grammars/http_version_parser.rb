require "webbed/grammars/parser"
require "webbed/grammars/core_rules"

module Webbed
  module Grammars
    # `HTTPVersionParser` parses HTTP versions into their major and minor
    # versions.
    #
    # @author Alexander Simon Kern (alex@kernul)
    # @api private
    class HTTPVersionParser < Parser
      include CoreRules

      rule(:http_version) { http_name >> str("/") >> digit.as(:major_version) >> str(".") >> digit.as(:minor_version) }
      rule(:http_name) { str("HTTP") }
      root(:http_version)
    end
  end
end
