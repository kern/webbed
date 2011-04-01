module Webbed
  module Helpers
    module RackRequestHelper
      module ClassMethods
        def from_rack(rack_env)
          env          = rack_env.dup
          method       = env.delete('REQUEST_METHOD')
          request_uri  = "#{env['PATH_INFO']}?#{env['QUERY_STRING']}"
          http_version = env.delete('HTTP_VERSION') || 'HTTP/1.1'
          scheme       = env.delete('rack.url_scheme')
          entity_body  = env.delete('rack.input')
          
          headers = env.inject({}) do |memo, h|
            memo[$1] = h[1] if h[0] =~ /^HTTP_(.*)/
            memo
          end
          
          headers['Content-Type']   = env.delete('CONTENT_TYPE')
          headers['Content-Length'] = env.delete('CONTENT_LENGTH')
          
          request = new([method, request_uri, headers, entity_body], {
            :http_version => http_version,
            :scheme       => scheme
          })
          
          request.rack_env = rack_env
          
          request
        end
      end
      
      module InstanceMethods
        attr_accessor :rack_env
      end
      
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :extend, ClassMethods
      end
    end
  end
end
