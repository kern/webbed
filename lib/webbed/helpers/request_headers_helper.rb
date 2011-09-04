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
      
      # The accepted Media Ranges of the Request (as defined in the Accept Header).
      # 
      # @param [Boolean] fix_text_xml_range if the broken `text/xml` range should be fixed
      # @return [<Webbed::MediaRange>, nil]
      def accepted_media_ranges(fix_text_xml_range = false)
        if headers['Accept']
          ranges = headers['Accept'].split(/\s*,\s*/).each_with_index.map do |media_type, index|
            Webbed::MediaRange.new(media_type, :order => index)
          end
          
          fix_text_html(ranges) if fix_text_xml_range
          ranges
        else
          [Webbed::MediaRange.new('*/*')]
        end
      end
      
      # Sets the accepted Media Ranges of the Request (as defined in the Accept Header).
      # 
      # @param [<#to_s>] accepted_media_ranges
      def accepted_media_ranges=(accepted_media_ranges)
        headers['Accept'] = accepted_media_ranges.join(', ')
      end
      
      # Negotiates which Media Type to use based on the accepted Media Ranges.
      # 
      # @param [<Webbed::MediaType>] media_types
      # @param [Boolean] fix_text_xml_range if the broken `text/xml` range should be fixed
      # @return [Webbed::MediaType, nil]
      def negotiate_media_type(media_types, fix_text_xml_range = false)
        ranges = accepted_media_ranges(fix_text_xml_range)
        negotiator = Webbed::ContentNegotiator.new(ranges)
        negotiator.negotiate(media_types)
      end
      
      # The accepted language ranges of the Request (as defined in the Accept-Language Header).
      #  
      # @return [<Webbed::LanguageRange>, nil]
      def accepted_language_ranges
        if headers['Accept-Language']
          headers['Accept-Language'].split(/\s*,\s*/).each_with_index.map do |language_tag, index|
            Webbed::LanguageRange.new(language_tag, :order => index)
          end
        else
          [Webbed::LanguageRange.new('*')]
        end
      end
      
      # Sets the accepted language ranges of the Request (as defined in the Accept-Language Header).
      # 
      # @param [<#to_s>] accepted_language_ranges
      def accepted_language_ranges=(accepted_language_ranges)
        headers['Accept-Language'] = accepted_language_ranges.join(', ')
      end
      
      # Negotiates which language tag to use based on the accepted language ranges.
      # 
      # @param [<Webbed::LanguageTag>] language_tags
      # @return [Webbed::LanguageTag, nil]
      def negotiate_language_tag(language_tags)
        negotiator = Webbed::ContentNegotiator.new(accepted_language_ranges)
        negotiator.negotiate(language_tags)
      end
      
      # TODO: Document these methods.
      def accepted_charsets
        if headers['Accept-Charset']
          charsets = headers['Accept-Charset'].split(/\s*,\s*/).each_with_index.map do |charset, index|
            Webbed::CharsetRange.new(charset, :order => index)
          end
          
          if charsets.none? { |charset| charset.star? }
            charsets.push(Webbed::CharsetRange.new('ISO-8859-1', :order => charsets.length))
          end
          
          charsets
        else
          [Webbed::CharsetRange.new('*')]
        end
      end
      
      def accepted_charsets=(accepted_charsets)
        headers['Accept-Charset'] = accepted_charsets.join(', ')
      end
      
      def negotiate_charset(charsets)
        negotiator = Webbed::ContentNegotiator.new(accepted_charsets)
        negotiator.negotiate(charsets)
      end
      
      private
      
      # Fixes the broken `text/html` in a list of Media Ranges.
      # 
      # This code is based off part of ActionDispatch.
      # 
      # @return [<Webbed::MediaRange>]
      # @see https://github.com/rails/rails/blob/master/actionpack/lib/action_dispatch/http/mime_type.rb ActionDispatch MIME type handler
      def fix_text_html(ranges)
        text_xml = ranges.find { |media_type| media_type.mime_type == 'text/xml' }
        application_xml = ranges.find { |media_type| media_type.mime_type == 'application/xml' }
        if text_xml && application_xml
          application_xml.order = [text_xml.order, application_xml.order].min
          application_xml.quality = [text_xml.quality, application_xml.quality].max
          ranges.delete(text_xml)
        elsif text_xml
          text_xml.mime_type = 'application/xml'
        end
      end
    end
  end
end