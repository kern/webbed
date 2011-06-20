module Webbed
  module Helpers
    # Request helper for Request Headers
    module RequestHeadersHelper
      # The Host of the Request (as defined in the Host Header).
      # 
      # @return [String, nil]
      def host
        headers['Host']
      end
      
      # Sets the Host of the Request (as defined in the Host Header).
      # 
      # @param [String] host
      def host=(host)
        headers['Host'] = host
      end
      
      # The From email of the Request (as defined in the From Header).
      # 
      # @return [String, nil]
      def from
        headers['From']
      end
      
      # Sets the From email of the Request (as defined in the From Header).
      # 
      # @param [String] from
      def from=(from)
        headers['From'] = from
      end
      
      # The Max-Forwards of the Request (as defined in the Max-Forwards Header).
      # 
      # @return [Fixnum, nil]
      def max_forwards
        headers['Max-Forwards'] ? headers['Max-Forwards'].to_i : nil
      end
      
      # Sets the Max-Forwards of the Request (as defined in the Max-Forwards Header).
      # 
      # @param [#to_s] max_forwards
      def max_forwards=(max_forwards)
        headers['Max-Forwards'] = max_forwards.to_s
      end
      
      # The Referer of the Request (as defined in the Referer Header).
      # 
      # @return [Addressable::URI, nil]
      def referer
        headers['Referer'] ? Addressable::URI.parse(headers['Referer']) : nil
      end
      
      # Sets the Referer of the Request (as defined in the Referer Header).
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
          headers['Accept'].split(/\s*,\s*/).map.with_index do |media_type, index|
            Webbed::MediaRange.new(media_type, :order => index)
          end
        else
          [Webbed::MediaRange.new('*/*')]
        end
      end
      
      # Sets the accepted Media Ranges of the Request (as defined in the Allow Header).
      # 
      # @param [<#to_s>] accepted_media_ranges
      def accepted_media_ranges=(accepted_media_ranges)
        headers['Accept'] = accepted_media_ranges.join(', ')
      end
      
      # Sorts the accepted Media Ranges of the Request in order of preference.
      # 
      # This code is based off part of ActionDispatch.
      # 
      # @return [<Webbed::MediaRange>]
      # @see https://github.com/rails/rails/blob/master/actionpack/lib/action_dispatch/http/mime_type.rb ActionDispatch MIME type handler
      def preferred_media_ranges
        accepted_media_ranges = self.accepted_media_ranges
        
        # Fix the broken `text/html` Media Range.
        text_xml = accepted_media_ranges.find { |media_type| media_type.mime_type == 'text/xml' }
        application_xml = accepted_media_ranges.find { |media_type| media_type.mime_type == 'application/xml' }
        if text_xml && application_xml
          application_xml.order = [text_xml.order, application_xml.order].max
          application_xml.quality = [text_xml.quality, application_xml.quality].max
          accepted_media_ranges.delete(text_xml)
        elsif text_xml
          text_xml.mime_type = 'application/xml'
        end
        
        accepted_media_ranges.sort.reverse
      end
      
      # Negotiates which Media Type to use based on the accepted Media Ranges.
      # 
      # @param [<Webbed::MediaType>] media_types
      # @return [Webbed::MediaType, nil]
      def negotiate_media_type(media_types)
        preferred_media_ranges = self.preferred_media_ranges
        matches = []
        
        media_types.each do |media_type|
          media_type_match = nil
          
          preferred_media_ranges.each do |media_range|
            if media_range.include?(media_type) && (!media_type_match || media_type_match.specificity < media_range.specificity)
              media_type_match = media_range
            end
          end
          
          if media_type_match && media_type_match.quality != 0
            matches.push([media_type, media_type_match])
          end
        end
        
        matches.sort! { |a, b| b[1] <=> a[1] }
        matches[0] ? matches[0][0] : nil
      end
    end
  end
end