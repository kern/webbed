require "treetop"

# Webbed provides two important abstraction on the HTTP specification (RFC
# 2616), {Webbed::Request} and {Webbed::Response}. Although the core classes
# have the bare-minimum of functionality for interacting with the two classes,
# they have been extended with a variety of helper modules, adding a significant
# amount of semantic meaning to the instances of each class.
#
# Webbed can be used with or without Rack, but it includes Rack helpers for
# convenience.
#
# @todo Add examples of webbed in action.
module Webbed
  # Namespace for all Treetop parsers and their nodes.
  module Grammars
    # Requires a Treetop grammar.
    #
    # @param [String] relative_path the relative path to the treetop grammar
    #   from the gem's `lib/` directory.
    # @api private
    def self.require_treetop(relative_path)
      absolute_path = File.expand_path("../#{relative_path}", __FILE__)
      Treetop.load(absolute_path)
    end

    require_treetop "webbed/grammars/basic_rules"
    require_treetop "webbed/grammars/qvalue"
    require_treetop "webbed/grammars/charset"
    require_treetop "webbed/grammars/charset_range"
    require_treetop "webbed/grammars/http_version"
  end

  require "webbed/headers"
  require "webbed/http_version"
  require "webbed/generic_message"
  require "webbed/language_tag"
  require "webbed/language_range"
  require "webbed/media_range"
  require "webbed/media_type"
  require "webbed/method"
  require "webbed/status_code"
  require "webbed/request"
  require "webbed/response"
  require "webbed/content_negotiator"
  require "webbed/negotiable"
  require "webbed/charset"
  require "webbed/charset_range"
  require "webbed/parse_error"
end
