# Webbed provides two important abstraction on the HTTP specification (RFC
# 2616), {Request} and {Response}. Although the core classes have the
# bare-minimum of functionality for interacting with the two classes, they have
# been extended with a variety of helper modules, adding a significant amount of
# semantic meaning to the instances of each class.
# 
# Webbed can be used with or without Rack, but it includes Rack helpers for
# convenience.
# 
# @todo Add examples of webbed in action.
module Webbed
  autoload :Headers,        'webbed/headers'
  autoload :HTTPVersion,    'webbed/http_version'
  autoload :GenericMessage, 'webbed/generic_message'
  autoload :MediaRange,     'webbed/media_range'
  autoload :MediaType,      'webbed/media_type'
  autoload :Method,         'webbed/method'
  autoload :StatusCode,     'webbed/status_code'
  autoload :Request,        'webbed/request'
  autoload :Response,       'webbed/response'
  
  module Helpers
    autoload :MethodHelper,          'webbed/helpers/method_helper'
    autoload :RackRequestHelper,     'webbed/helpers/rack_request_helper'
    autoload :RackResponseHelper,    'webbed/helpers/rack_response_helper'
    autoload :RequestURIHelper,      'webbed/helpers/request_uri_helper'
    autoload :SchemeHelper,          'webbed/helpers/scheme_helper'
    autoload :RequestHeadersHelper,  'webbed/helpers/request_headers_helper'
    autoload :ResponseHeadersHelper, 'webbed/helpers/response_headers_helper'
    autoload :EntityHeadersHelper,   'webbed/helpers/entity_headers_helper'
  end
end