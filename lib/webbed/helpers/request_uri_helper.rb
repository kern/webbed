module Webbed
  module Helpers
    # Request helper for the Request-URI
    module RequestURIHelper
      # Aliases the {Request#request_uri} method to `#request_url`.
      def self.included(base)
        base.class_eval do
          alias :request_url :request_uri
        end
      end
      
      # The URI of the actual location of the requested resource.
      # 
      # If the Request-URI is an absolute URI or there is no Host header, it
      # returns the Request-URI.
      # 
      # If the Request-URI is a relative URI, it combines the Host header with
      # the Request-URI.
      # 
      # @return [Addressable::URI]
      def uri
        if host && !request_uri.host
          request_uri.dup.tap do |uri|
            uri.scheme = 'http'
            uri.host = host
          end
        else
          request_uri
        end
      end
      alias :url :uri
    end
  end
end