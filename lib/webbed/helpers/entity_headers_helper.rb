module Webbed
  module Helpers
    # Request and Response helper for Entity Headers
    module EntityHeadersHelper
      # The Content-Length of the Entity (as defined in the Content-Length Header).
      # 
      # @return [Fixnum, nil]
      def content_length
        headers['Content-Length'] ? headers['Content-Length'].to_i : nil
      end
      
      # Sets the Content-Length of the Entity (as defined in the Content-Length Header).
      # 
      # @param new_content_length [#to_s]
      def content_length=(new_content_length)
        headers['Content-Length'] = new_content_length.to_s
      end
      
      # The Content-Location of the Entity (as defined in the Content-Location Header).
      # 
      # @return [Addressable::URI, nil]
      def content_location
        headers['Content-Location'] ? Addressable::URI.parse(headers['Content-Location']) : nil
      end
      
      # Sets the Content-Location of the Entity (as defined in the Content-Location Header).
      # 
      # @param new_content_location [#to_s]
      def content_location=(new_content_location)
        headers['Content-Location'] = new_content_location.to_s
      end
      
      # The Content-MD5 of the Entity (as defined in the Content-MD5 Header).
      # 
      # @return [String, nil]
      def content_md5
        headers['Content-MD5']
      end
      
      # Sets the Content-MD5 of the Entity (as defined in the Content-MD5 Header).
      # 
      # @param new_content_md5 [String]
      def content_md5=(new_content_md5)
        headers['Content-MD5'] = new_content_md5
      end
      
      # The Content-Type of the Entity (as defined in the Content-Type Header).
      # 
      # @return [MediaType, nil]
      def content_type
        headers['Content-Type'] ? Webbed::MediaType.new(headers['Content-Type']) : nil
      end
      
      # Sets the Content-Type of the Entity (as defined in the Content-Type Header).
      # 
      # @param new_content_type [#to_s]
      def content_type=(new_content_type)
        headers['Content-Type'] = new_content_type.to_s
      end
    end
  end
end