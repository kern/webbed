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
  autoload :Headers,           "webbed/headers"
  autoload :HTTPVersion,       "webbed/http_version"
  autoload :GenericMessage,    "webbed/generic_message"
  autoload :LanguageTag,       "webbed/language_tag"
  autoload :LanguageRange,     "webbed/language_range"
  autoload :MediaRange,        "webbed/media_range"
  autoload :MediaType,         "webbed/media_type"
  autoload :Method,            "webbed/method"
  autoload :StatusCode,        "webbed/status_code"
  autoload :Request,           "webbed/request"
  autoload :Response,          "webbed/response"
  autoload :ContentNegotiator, "webbed/content_negotiator"
  autoload :Negotiable,        "webbed/negotiable"
  autoload :Charset,           "webbed/charset"
  autoload :CharsetRange,      "webbed/charset_range"
  require "webbed/parse_error"

  module Helpers
    autoload :MethodHelper,          "webbed/helpers/method_helper"
    autoload :RackRequestHelper,     "webbed/helpers/rack_request_helper"
    autoload :RackResponseHelper,    "webbed/helpers/rack_response_helper"
    autoload :RequestURIHelper,      "webbed/helpers/request_uri_helper"
    autoload :SchemeHelper,          "webbed/helpers/scheme_helper"
    autoload :RequestHeadersHelper,  "webbed/helpers/request_headers_helper"
    autoload :ResponseHeadersHelper, "webbed/helpers/response_headers_helper"
    autoload :EntityHeadersHelper,   "webbed/helpers/entity_headers_helper"
  end

  module Grammars
    # Requires a Treetop grammar.
    #
    # @param [String] relative_path the relative path to the treetop grammar
    #   from the gem's `lib/` directory.
    # @api private
    def self.require_treetop(relative_path)
      Treetop.load File.expand_path("../#{relative_path}", __FILE__)
    end

    require_treetop "webbed/grammars/basic_rules"
    require_treetop "webbed/grammars/qvalue"
    require_treetop "webbed/grammars/charset"
    require_treetop "webbed/grammars/charset_range"
    require_treetop "webbed/grammars/http_version"

    require "webbed/grammars/charset_node"
    require "webbed/grammars/charset_range_node"
    require "webbed/grammars/qvalue_node"
    require "webbed/grammars/qparam_node"
    require "webbed/grammars/http_version_node"
    require "webbed/grammars/http_major_version_node"
    require "webbed/grammars/http_minor_version_node"
  end
end
