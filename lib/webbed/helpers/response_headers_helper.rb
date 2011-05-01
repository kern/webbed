module Webbed
  module Helpers
    # Response helper for Response Headers
    module ResponseHeadersHelper
      # The ETag of the Response (as defined in the ETag Header)
      # 
      # @return [String, nil]
      def etag
        headers['ETag']
      end
      
      # Sets the ETag of the Response (as defined in the ETag Header)
      # 
      # @param new_etag [String]
      def etag=(new_etag)
        headers['ETag'] = new_etag
      end
      
      # The Age of the Response (as defined in the Age Header)
      # 
      # @return [Fixnum, nil]
      def age
        headers['Age'] ? headers['Age'].to_i : nil
      end
      
      # Sets the Age of the Response (as defined in the Age Header)
      # 
      # @param new_age [#to_s]
      def age=(new_age)
        headers['Age'] = new_age.to_s
      end
      
      # The Location of the Response (as defined in the Location Header)
      # 
      # @return [Addressable::URI, nil]
      def location
        headers['Location'] ? Addressable::URI.parse(headers['Location']) : nil
      end
      
      # Sets the Location of the Response (as defined in the Location Header)
      # 
      # @param new_location [#to_s]
      def location=(new_location)
        headers['Location'] = new_location.to_s
      end
    end
  end
end