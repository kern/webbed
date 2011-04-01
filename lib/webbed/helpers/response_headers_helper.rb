module Webbed
  module Helpers
    module ResponseHeadersHelper
      def etag
        headers['ETag']
      end
      
      def etag=(etag)
        headers['ETag'] = etag
      end
      
      def age
        headers['Age'] ? headers['Age'].to_i : nil
      end
      
      def age=(age)
        headers['Age'] = age.to_s
      end
    end
  end
end