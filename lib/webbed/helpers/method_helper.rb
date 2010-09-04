module Webbed
  module Helpers
    module MethodHelper
      def safe?
        method.safe?
      end
      
      def idempotent?
        method.idempotent?
      end
      
      def options?
        method == 'OPTIONS'
      end
      
      def get?
        method == 'GET'
      end
      
      def head?
        method == 'HEAD'
      end
      
      def post?
        method == 'POST'
      end
      
      def put?
        method == 'PUT'
      end
      
      def delete?
        method == 'DELETE'
      end
      
      def trace?
        method == 'TRACE'
      end
      
      def connect?
        method == 'CONNECT'
      end
      
      def patch?
        method == 'PATCH'
      end
    end
  end
end