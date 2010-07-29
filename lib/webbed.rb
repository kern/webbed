module Webbed
  autoload :Headers, 'webbed/headers'
  autoload :HTTPVersion, 'webbed/http_version'
  autoload :GenericMessage, 'webbed/generic_message'
  autoload :Method, 'webbed/method'
  autoload :StatusCode, 'webbed/status_code'
  autoload :Request, 'webbed/request'
  autoload :Response, 'webbed/response'
  
  module Extensions
    autoload :MethodAliases, 'webbed/extensions/method_aliases'
    autoload :RequestUriAliases, 'webbed/extensions/request_uri_aliases'
  end
end