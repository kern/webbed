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
      end
      
      test '#preferred_media_ranges' do
        assert_equal '*/*', @request.preferred_media_ranges[0].to_s
        
        @request.headers['Accept'] = 'text/*;q=0.3, text/html;q=0.7, text/html;level=1, text/html;level=2, text/html;level=2;q=0.4, */*;q=0.5'
        assert_equal 'text/html; level=1', @request.preferred_media_ranges[0].to_s
        assert_equal 'text/html; level=2', @request.preferred_media_ranges[1].to_s
        assert_equal 'text/html; q=0.7', @request.preferred_media_ranges[2].to_s
        assert_equal '*/*; q=0.5', @request.preferred_media_ranges[3].to_s
        assert_equal 'text/html; q=0.4; level=2', @request.preferred_media_ranges[4].to_s
        assert_equal 'text/*; q=0.3', @request.preferred_media_ranges[5].to_s
        
        @request.headers['Accept'] = 'text/xml'
        assert_equal 'application/xml', @request.preferred_media_ranges[0].to_s
        
        @request.headers['Accept'] = 'text/xml;q=0.7, application/json;q=0.6, application/xml;q=0.5'
        assert_equal 'application/xml; q=0.7', @request.preferred_media_ranges[0].to_s
        assert_equal 'application/json; q=0.6', @request.preferred_media_ranges[1].to_s
      end
      
      test '#negotiate_media_type' do
        text_html = Webbed::MediaType.new('text/html')
        application_json = Webbed::MediaType.new('application/json')
        
        assert_equal text_html, @request.negotiate_media_type([text_html])
        assert_equal text_html, @request.negotiate_media_type([text_html, application_json])
        
        @request.headers['Accept'] = 'application/*'
        assert_nil @request.negotiate_media_type([text_html])
        assert_equal application_json, @request.negotiate_media_type([text_html, application_json])
        
        @request.headers['Accept'] = 'application/*, text/*'
        assert_equal text_html, @request.negotiate_media_type([text_html])
        assert_equal application_json, @request.negotiate_media_type([text_html, application_json])
        
        @request.headers['Accept'] = 'text/*, application/*'
        assert_equal text_html, @request.negotiate_media_type([text_html])
        assert_equal text_html, @request.negotiate_media_type([text_html, application_json])
        
        @request.headers['Accept'] = 'text/*;q=0, application/*'
        assert_nil @request.negotiate_media_type([text_html])
        assert_equal application_json, @request.negotiate_media_type([text_html, application_json])
        
        @request.headers['Accept'] = 'text/*, text/html;q=0.2, application/json;q=0.5'
        assert_equal text_html, @request.negotiate_media_type([text_html])
        assert_equal application_json, @request.negotiate_media_type([text_html, application_json])
      end
    end
  end
end