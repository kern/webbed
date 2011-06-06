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
        assert_nil @request.accepted_media_ranges
        
        @request.headers['Accept'] = 'text/plain; q=0.5, text/html, text/x-dvi; q=0.8, text/x-c, */*'
        assert_equal 'text/plain', @request.accepted_media_ranges[0].mime_type
        assert_equal 0.5, @request.accepted_media_ranges[0].quality
        assert_equal 'text/html', @request.accepted_media_ranges[1].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[1].quality
        assert_equal 'text/x-dvi', @request.accepted_media_ranges[2].mime_type
        assert_equal 0.8, @request.accepted_media_ranges[2].quality
        assert_equal 'text/x-c', @request.accepted_media_ranges[3].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[3].quality
        assert_equal '*/*', @request.accepted_media_ranges[4].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[4].quality
        
        @request.accepted_media_ranges = ['text/*', Webbed::MediaType.new('text/html'), 'text/html;level=1', '*/*']
        assert_equal 'text/*, text/html, text/html;level=1, */*', @request.headers['Accept']
        assert_equal 'text/*', @request.accepted_media_ranges[0].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[0].quality
        assert_equal 'text/html', @request.accepted_media_ranges[1].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[1].quality
        assert_equal 'text/html', @request.accepted_media_ranges[2].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[2].quality
        assert_equal '1', @request.accepted_media_ranges[2].parameters['level']
        assert_equal '*/*', @request.accepted_media_ranges[3].mime_type
        assert_equal 1.0, @request.accepted_media_ranges[3].quality
      end
    end
  end
end