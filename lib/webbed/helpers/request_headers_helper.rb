module Webbed
  module Helpers
    module RequestHeadersHelper
      def host
        headers['Host']
      end
      
      def host=(host)
        headers['Host'] = host
      end
      
      def from
        headers['From']
      end
      
      def from=(from)
        headers['From'] = from
      end
      
      def max_forwards
        headers['Max-Forwards'] ? headers['Max-Forwards'].to_i : nil
      end
      
      def max_forwards=(max_forwards)
        headers['Max-Forwards'] = max_forwards.to_s
      end
      
      def referer
        headers['Referer'] ? Addressable::URI.parse(headers['Referer']) : nil
      end
      
      def referer=(referer)
        headers['Referer'] = referer.to_s
      end
    end
  end
end