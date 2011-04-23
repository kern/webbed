module Webbed
  module Helpers
    # Request helper for Request Headers
    module RequestHeadersHelper
      # The Host of the Request (as defined in the Host Header)
      # 
      # @return [String, nil]
      def host
        headers['Host']
      end
      
      # Sets the Host of the Request (as defined in the Host Header)
      # 
      # @param new_host [String]
      def host=(new_host)
        headers['Host'] = new_host
      end
      
      # The From email of the Request (as defined in the From Header)
      # 
      # @return [String, nil]
      def from
        headers['From']
      end
      
      # Sets the From email of the Request (as defined in the From Header)
      # 
      # @param new_from [String]
      def from=(new_from)
        headers['From'] = new_from
      end
      
      # The Max-Forwards of the Request (as defined in the Max-Forwards Header)
      # 
      # @return [Fixnum, nil]
      def max_forwards
        headers['Max-Forwards'] ? headers['Max-Forwards'].to_i : nil
      end
      
      # Sets the Max-Forwards of the Request (as defined in the Max-Forwards Header)
      # 
      # @param new_max_forwards [#to_s]
      def max_forwards=(new_max_forwards)
        headers['Max-Forwards'] = new_max_forwards.to_s
      end
      
      # The Referer of the Request (as defined in the Referer Header)
      # 
      # @return [Addressable::URI, nil]
      def referer
        headers['Referer'] ? Addressable::URI.parse(headers['Referer']) : nil
      end
      
      # Sets the Referer of the Request (as defined in the Referer Header)
      # 
      # @param new_referer [#to_s]
      def referer=(new_referer)
        headers['Referer'] = new_referer.to_s
      end
    end
  end
end