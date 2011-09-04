require 'test_helper'

module WebbedTest
  module HelperTest
    class RequestHeadersHelper < TestCase
      def setup
        @request = Webbed::Request.new('GET', '*', {}, '')
      end
      
      test '#host' do
        assert_nil @request.host
        
        @request.headers['Host'] = 'example.com'
        assert_equal 'example.com', @request.host
        
        @request.host = 'test.com'
        assert_equal 'test.com', @request.host
        assert_equal 'test.com', @request.headers['Host']
      end
      
      test '#from' do
        assert_nil @request.from
        
        @request.headers['From'] = 'test@example.com'
        assert_equal 'test@example.com', @request.from
        
        @request.from = 'foo@bar.com'
        assert_equal 'foo@bar.com', @request.from
        assert_equal 'foo@bar.com', @request.headers['From']
      end
      
      test '#max_forwards' do
        assert_nil @request.max_forwards
        
        @request.headers['Max-Forwards'] = '56'
        assert_equal 56, @request.max_forwards
        
        @request.max_forwards = 1234
        assert_equal 1234, @request.max_forwards
        assert_equal '1234', @request.headers['Max-Forwards']
      end
      
      test '#referer' do
        assert_nil @request.referer
        
        @request.headers['Referer'] = 'http://foo.com'
        assert_instance_of Addressable::URI, @request.referer
        assert_equal Addressable::URI.parse('http://foo.com'), @request.referer
        
        @request.referer = 'http://example.com'
        assert_instance_of Addressable::URI, @request.referer
        assert_equal Addressable::URI.parse('http://example.com'), @request.referer
        assert_equal 'http://example.com', @request.headers['Referer']
      end
      
      test '#accepted_media_ranges' do
        assert_equal '*/*', @request.accepted_media_ranges[0].mime_type
        assert_equal 1, @request.accepted_media_ranges[0].quality
        assert_equal 0, @request.accepted_media_ranges[0].order
        
        @request.headers['Accept'] = 'text/plain; q=0.5, text/html, text/x-dvi; q=0.8, text/x-c, */*'
        assert_equal 'text/plain', @request.accepted_media_ranges[0].mime_type
        assert_equal 0.5, @request.accepted_media_ranges[0].quality
        assert_equal 0, @request.accepted_media_ranges[0].order
        assert_equal 'text/html', @request.accepted_media_ranges[1].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[1].quality
        assert_equal 1, @request.accepted_media_ranges[1].order
        assert_equal 'text/x-dvi', @request.accepted_media_ranges[2].mime_type
        assert_equal 0.8, @request.accepted_media_ranges[2].quality
        assert_equal 2, @request.accepted_media_ranges[2].order
        assert_equal 'text/x-c', @request.accepted_media_ranges[3].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[3].quality
        assert_equal 3, @request.accepted_media_ranges[3].order
        assert_equal '*/*', @request.accepted_media_ranges[4].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[4].quality
        assert_equal 4, @request.accepted_media_ranges[4].order
        
        @request.accepted_media_ranges = ['text/*', Webbed::MediaType.new('text/html'), 'text/html;level=1', '*/*']
        assert_equal 'text/*, text/html, text/html;level=1, */*', @request.headers['Accept']
        assert_equal 'text/*', @request.accepted_media_ranges[0].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[0].quality
        assert_equal 0, @request.accepted_media_ranges[0].order
        assert_equal 'text/html', @request.accepted_media_ranges[1].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[1].quality
        assert_equal 1, @request.accepted_media_ranges[1].order
        assert_equal 'text/html', @request.accepted_media_ranges[2].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[2].quality
        assert_equal '1', @request.accepted_media_ranges[2].parameters['level']
        assert_equal 2, @request.accepted_media_ranges[2].order
        assert_equal '*/*', @request.accepted_media_ranges[3].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[3].quality
        assert_equal 3, @request.accepted_media_ranges[3].order
        
        @request.headers['Accept'] = 'text/xml'
        assert_equal 'application/xml', @request.accepted_media_ranges(true)[0].mime_type
        assert_equal 1.0, @request.accepted_media_ranges(true)[0].quality
        assert_equal 0, @request.accepted_media_ranges(true)[0].order
        
        @request.headers['Accept'] = 'text/xml;q=0.7, application/json;q=0.6, application/xml;q=0.5'
        assert_equal 'application/json', @request.accepted_media_ranges(true)[0].mime_type
        assert_equal 0.6, @request.accepted_media_ranges(true)[0].quality
        assert_equal 1, @request.accepted_media_ranges(true)[0].order
        assert_equal 'application/xml', @request.accepted_media_ranges(true)[1].mime_type
        assert_equal 0.7, @request.accepted_media_ranges(true)[1].quality
        assert_equal 0, @request.accepted_media_ranges(true)[1].order
      end
      
      test '#negotiate_media_type' do
        text_html = Webbed::MediaType.new('text/html')
        application_json = Webbed::MediaType.new('application/json')
        
        assert_equal text_html, @request.negotiate_media_type([text_html])
        assert_equal text_html, @request.negotiate_media_type([text_html, application_json])
        
        @request.headers['Accept'] = 'text/*, text/html;q=0.2, application/json;q=0.5'
        assert_equal text_html, @request.negotiate_media_type([text_html])
        assert_equal application_json, @request.negotiate_media_type([text_html, application_json])
      end
      
      test '#accepted_language_ranges' do
        assert_equal '*', @request.accepted_language_ranges[0].range
        assert_equal 1, @request.accepted_language_ranges[0].quality
        assert_equal 0, @request.accepted_language_ranges[0].order
        
        @request.headers['Accept-Language'] = 'en-gb; q=0.5, en-us, x-pig-latin; q=0.8, i-cherokee, *'
        assert_equal 'en-gb', @request.accepted_language_ranges[0].range
        assert_equal 0.5, @request.accepted_language_ranges[0].quality
        assert_equal 0, @request.accepted_language_ranges[0].order
        assert_equal 'en-us', @request.accepted_language_ranges[1].range
        assert_equal 1.0, @request.accepted_language_ranges[1].quality
        assert_equal 1, @request.accepted_language_ranges[1].order
        assert_equal 'x-pig-latin', @request.accepted_language_ranges[2].range
        assert_equal 0.8, @request.accepted_language_ranges[2].quality
        assert_equal 2, @request.accepted_language_ranges[2].order
        assert_equal 'i-cherokee', @request.accepted_language_ranges[3].range
        assert_equal 1.0, @request.accepted_language_ranges[3].quality
        assert_equal 3, @request.accepted_language_ranges[3].order
        assert_equal '*', @request.accepted_language_ranges[4].range
        assert_equal 1.0, @request.accepted_language_ranges[4].quality
        assert_equal 4, @request.accepted_language_ranges[4].order
        
        @request.accepted_language_ranges = ['en', Webbed::LanguageRange.new('en-gb'), 'en-gb-foo', '*']
        assert_equal 'en, en-gb, en-gb-foo, *', @request.headers['Accept-Language']
        assert_equal 'en', @request.accepted_language_ranges[0].range
        assert_equal 1.0, @request.accepted_language_ranges[0].quality
        assert_equal 0, @request.accepted_language_ranges[0].order
        assert_equal 'en-gb', @request.accepted_language_ranges[1].range
        assert_equal 1.0, @request.accepted_language_ranges[1].quality
        assert_equal 1, @request.accepted_language_ranges[1].order
        assert_equal 'en-gb-foo', @request.accepted_language_ranges[2].range
        assert_equal 1.0, @request.accepted_language_ranges[2].quality
        assert_equal 2, @request.accepted_language_ranges[2].order
        assert_equal '*', @request.accepted_language_ranges[3].range
        assert_equal 1.0, @request.accepted_language_ranges[3].quality
        assert_equal 3, @request.accepted_language_ranges[3].order
      end
      
      test '#negotiate_language_tag' do
        en_gb = Webbed::LanguageTag.new('en-gb')
        i_cherokee = Webbed::LanguageTag.new('i-cherokee')
        
        assert_equal en_gb, @request.negotiate_language_tag([en_gb])
        assert_equal en_gb, @request.negotiate_language_tag([en_gb, i_cherokee])
        
        @request.headers['Accept-Language'] = 'en, en-gb;q=0.2, i;q=0.5'
        assert_equal en_gb, @request.negotiate_language_tag([en_gb])
        assert_equal i_cherokee, @request.negotiate_language_tag([en_gb, i_cherokee])
      end
      
      test '#accepted_charsets' do
        assert_equal '*', @request.accepted_charsets[0].to_s
        
        @request.headers['Accept-Charset'] = 'macedonian'
        assert_equal 'macedonian', @request.accepted_charsets[0].to_s
        assert_equal 0, @request.accepted_charsets[0].order
        assert_equal 'ISO-8859-1', @request.accepted_charsets[1].to_s
        assert_equal 1, @request.accepted_charsets[1].order
        
        @request.accepted_charsets = [Webbed::CharsetRange.new('*'), 'macedonian']
        assert_equal '*, macedonian', @request.headers['Accept-Charset']
        assert_equal '*', @request.accepted_charsets[0].to_s
        assert_equal 0, @request.accepted_charsets[0].order
        assert_equal 'macedonian', @request.accepted_charsets[1].to_s
        assert_equal 1, @request.accepted_charsets[1].order
        
        @request.headers['Accept-Charset'] = 'ISO-8859-1'
        assert_equal 'ISO-8859-1', @request.accepted_charsets[0].to_s
      end
      
      test '#negotiate_charset' do
        macedonian = Webbed::Charset.new('macedonian')
        iso_8859_1 = Webbed::Charset.new('ISO-8859-1')
        
        assert_equal macedonian, @request.negotiate_charset([macedonian])
        assert_equal macedonian, @request.negotiate_charset([macedonian, iso_8859_1])
        
        @request.headers['Accept-Charset'] = ''
        assert_nil @request.negotiate_charset([macedonian])
        assert_equal iso_8859_1, @request.negotiate_charset([macedonian, iso_8859_1])
      end
    end
  end
end