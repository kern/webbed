module Webbed
  module Extensions
    module MethodAliases
      def safe?
        method.safe?
      end
      
      def unsafe?
        !safe?
      end
      
      def idempotent?
        method.idempotent?
      end
      
      def nonidempotent?
        !idempotent?
      end
    end
  end
end