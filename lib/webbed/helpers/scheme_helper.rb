module Webbed
  module Helpers
    module SchemeHelper
      def secure?
        scheme == 'https'
      end
      
      def default_port
        case scheme
        when 'http' then 80
        when 'https' then 443
        end
      end
    end
  end
end