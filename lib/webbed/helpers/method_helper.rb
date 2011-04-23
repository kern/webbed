module Webbed
  module Helpers
    # Request helper for the Method
    module MethodHelper
      # Whether or not the Request is safe based on the Method
      # 
      # @return [Boolean]
      def safe?
        method.safe?
      end
      
      # Whether or not the Request is idempotent based on the Method
      # 
      # @return [Boolean]
      def idempotent?
        method.idempotent?
      end
      
      # Whether or not the Request uses the OPTIONS Method
      # 
      # @return [Boolean]
      def options?
        method == 'OPTIONS'
      end
      
      # Whether or not the Request uses the GET Method
      # 
      # @return [Boolean]
      def get?
        method == 'GET'
      end
      
      # Whether or not the Request uses the HEAD Method
      # 
      # @return [Boolean]
      def head?
        method == 'HEAD'
      end
      
      # Whether or not the Request uses the POST Method
      # 
      # @return [Boolean]
      def post?
        method == 'POST'
      end
      
      # Whether or not the Request uses the PUT Method
      # 
      # @return [Boolean]
      def put?
        method == 'PUT'
      end
      
      # Whether or not the Request uses the DELETE Method
      # 
      # @return [Boolean]
      def delete?
        method == 'DELETE'
      end
      
      # Whether or not the Request uses the TRACE Method
      # 
      # @return [Boolean]
      def trace?
        method == 'TRACE'
      end
      
      # Whether or not the Request uses the CONNECT Method
      # 
      # @return [Boolean]
      def connect?
        method == 'CONNECT'
      end
      
      # Whether or not the Request uses the PATCH Method
      # 
      # @return [Boolean]
      def patch?
        method == 'PATCH'
      end
    end
  end
end