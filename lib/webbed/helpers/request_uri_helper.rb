module Webbed
  module Helpers
    module RequestUriHelper
      def self.included(base)
        base.class_eval do
          alias :uri :request_uri
          alias :url :request_uri
          alias :request_url :request_uri
        end
      end
    end
  end
end