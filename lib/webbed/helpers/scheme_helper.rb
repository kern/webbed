module Webbed
  module Helpers
    # Request helper for the schemes
    module SchemeHelper
      # Whether or not the request was sent securely (using HTTPS)
      # 
      # @return [Boolean]
      def secure?
        scheme == 'https'
      end
      
      # The default port for the designated scheme
      # 
      # This method returns `80` if you're using HTTP and `443` if you're using
      # HTTPS.
      # 
      # @return [Fixnum, nil]
      def default_port
        case scheme
        when 'http' then 80
        when 'https' then 443
        end
      end
    end
  end
end