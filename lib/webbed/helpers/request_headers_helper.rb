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
      # @param [String] host
      def host=(host)
        headers['Host'] = host
      end
      
      # The From email of the Request (as defined in the From Header)
      # 
      # @return [String, nil]
      def from
        headers['From']
      end
      
      # Sets the From email of the Request (as defined in the From Header)
      # 
      # @param [String] from
      def from=(from)
        headers['From'] = from
      end
      
      # The Max-Forwards of the Request (as defined in the Max-Forwards Header)
      # 
      # @return [Fixnum, nil]
      def max_forwards
        headers['Max-Forwards'] ? headers['Max-Forwards'].to_i : nil
      end
      
      # Sets the Max-Forwards of the Request (as defined in the Max-Forwards Header)
      # 
      # @param [#to_s] max_forwards
      def max_forwards=(max_forwards)
        headers['Max-Forwards'] = max_forwards.to_s
      end
      
      # The Referer of the Request (as defined in the Referer Header)
      # 
      # @return [Addressable::URI, nil]
      def referer
        headers['Referer'] ? Addressable::URI.parse(headers['Referer']) : nil
      end
      
      # Sets the Referer of the Request (as defined in the Referer Header)
      # 
      # @param [#to_s] referer
      def referer=(referer)
        headers['Referer'] = referer.to_s
      end
      
      # The accepted Media Ranges of the Request (as defined in the Allow Header).
      # 
      # @return [<Webbed::MediaRange>, nil]
      def accepted_media_ranges
        if headers['Accept']
          headers['Accept'].split(/\s*,\s*/).map do |media_type|
            Webbed::MediaRange.new(media_type)
          end
        else
          nil
        end
      end
      
      # Sets the accepted Media Ranges of the Request (as defined in the Allow Header).
      # 
      # @param [<#to_s>] accepted_media_ranges
      def accepted_media_ranges=(accepted_media_ranges)
        headers['Accept'] = accepted_media_ranges.join(', ')
      end
    end
  end
end