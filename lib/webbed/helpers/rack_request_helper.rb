module Webbed
  module Helpers
    # Request helper for converting Rack environments into Requests
    module RackRequestHelper
      module ClassMethods
        # Create a new Request from a Rack environment
        # 
        # This method will take the HTTP-Version, Method, Request-URI, Headers,
        # Entity Body, and scheme from the Rack environment and create a new
        # Request using that data. The Rack environment can be accessed through
        # `#rack_env`.
        # 
        # @param [Hash{String => String}] rack_env
        # @return [Request]
        # @note The Rack environment will never be modified.
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
        # The Rack environment of the Request
        # 
        # @return [Hash{String => String}]
        attr_accessor :rack_env
      end
      
      # @see ClassMethods
      # @see InstanceMethods
      def self.included(base)
        base.send :include, InstanceMethods
        base.send :extend, ClassMethods
      end
    end
  end
end
