module Webbed
  module Helpers
    module RequestUriHelper
      def self.included(base)
        base.class_eval do
          alias :request_url :request_uri
        end
      end
      
      def host
        headers['Host']
      end
      
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
    end
  end
end