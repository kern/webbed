module Webbed
  module Helpers
    module EntityHeadersHelper
      def content_length
        headers['Content-Length'] ? headers['Content-Length'].to_i : nil
      end
      
      def content_length=(content_length)
        headers['Content-Length'] = content_length.to_s
      end
      
      def content_location
        headers['Content-Location'] ? Addressable::URI.parse(headers['Content-Location']) : nil
      end
      
      def content_location=(content_location)
        headers['Content-Location'] = content_location.to_s
      end
      
      def content_md5
        headers['Content-MD5']
      end
      
      def content_md5=(content_md5)
        headers['Content-MD5'] = content_md5
      end
      
      def content_type
        headers['Content-Type'] ? Webbed::MediaType.new(headers['Content-Type']) : nil
      end
      
      def content_type=(content_type)
        headers['Content-Type'] = content_type.to_s
      end
    end
  end
end