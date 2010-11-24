module Webbed
  autoload :Headers, 'webbed/headers'
  autoload :HTTPVersion, 'webbed/http_version'
  autoload :GenericMessage, 'webbed/generic_message'
  autoload :MediaType, 'webbed/media_type'
  autoload :Method, 'webbed/method'
  autoload :StatusCode, 'webbed/status_code'
  autoload :Request, 'webbed/request'
  autoload :Response, 'webbed/response'
  
  module Helpers
    autoload :MethodHelper, 'webbed/helpers/method_helper'
    autoload :RackResponseHelper, 'webbed/helpers/rack_response_helper'
    autoload :RequestURIHelper, 'webbed/helpers/request_uri_helper'
  end
end