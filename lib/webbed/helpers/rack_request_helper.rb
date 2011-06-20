module Webbed
  module Helpers
    # Request helper for converting Rack environments into Requests
    module RackRequestHelper
      module ClassMethods
        # Create a new Request from a Rack environment
        # 
        # This method will take the HTTP Version, Method, Request-URI, Headers,
        # Entity Body, and scheme from the Rack environment and create a new
        # Request using that data. The Rack environment can be accessed through
        # `#rack_env`.
        # 
        # @param [{String => String}] rack_env
        # @return [Webbed::Request]
        # @note The Rack environment will never be modified.
        def from_rack(rack_env)
          env          = rack_env.dup
          method       = env.delete('REQUEST_METHOD')
          request_uri  = "#{env['PATH_INFO']}?#{env['QUERY_STRING']}"
          http_version = env.delete('HTTP_VERSION') || 'HTTP/1.1'
          scheme       = env.delete('rack.url_scheme')
          entity_body  = env.delete('rack.input')
          
          headers = env.inject({}) do |memo, h|
            memo[$1.gsub('_', '-')] = h[1] if h[0] =~ /^HTTP_(.*)/
            memo
          end
          
          headers['Content-Type']   = env.delete('CONTENT_TYPE')
          headers['Content-Length'] = env.delete('CONTENT_LENGTH')
          
          request = new(method, request_uri, headers, entity_body, {
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
        # @return [{String => String}]
        attr_accessor :rack_env
        
        # Generate the Rack enivronment equivalent of the Request.
        # 
        # If the Request was created with an environment, the generated
        # environment will be merged with the original environment. The original
        # will not be modified.
        # 
        # @return [{String => String}]
        def to_rack
          env = rack_env ? rack_env.dup : {}
          env['REQUEST_METHOD'] = method.to_s
          env['PATH_INFO'] = request_uri.path
          env['QUERY_STRING'] = request_uri.query
          env['HTTP_VERSION'] = http_version.to_s
          env['rack.url_scheme'] = scheme
          env['rack.input'] = entity_body
          
          rack_headers = headers.dup
          env['CONTENT_TYPE'] = rack_headers.delete('Content-Type')
          env['CONTENT_LENGTH'] = rack_headers.delete('Content-Length')
          
          rack_headers.each do |header, value|
            header = header.upcase.gsub('-', '_')
            env["HTTP_#{header}"] = value
          end
          
          env
        end
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