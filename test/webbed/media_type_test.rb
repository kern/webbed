require 'test_helper'

module WebbedTest
  class MediaTypeTest < TestCase
    test '#initialize with only MIME type' do
      media_type = Webbed::MediaType.new('text/html')
      
      assert_equal 'text', media_type.type
      assert_equal 'html', media_type.subtype
      assert_equal 'text/html', media_type.mime_type
      assert media_type.parameters.empty?
    end
    
    test '#initialize with MIME type and parameters' do
      media_type = Webbed::MediaType.new('text/html; foo=bar; lol=rofl')
      
      assert_equal 'text', media_type.type
      assert_equal 'html', media_type.subtype
      assert_equal 'text/html', media_type.mime_type
      assert_equal 'bar', media_type.parameters['foo']
      assert_equal 'rofl', media_type.parameters['lol']
    end
    
    test '#initialize with MIME type and weirdly spaced parameters' do
      media_type = Webbed::MediaType.new('text/html;   foo=bar ; lol=rofl')
      
      assert_equal 'text', media_type.type
      assert_equal 'html', media_type.subtype
      assert_equal 'text/html', media_type.mime_type
      assert_equal 'bar', media_type.parameters['foo']
      assert_equal 'rofl', media_type.parameters['lol']
    end
    
    test '#mime_type' do
      media_type = Webbed::MediaType.new('text/html; foo=bar; lol=rofl')
      media_type.mime_type = 'application/json'
      
      assert_equal 'application', media_type.type
      assert_equal 'json', media_type.subtype
      assert_equal 'application/json', media_type.mime_type
    end
    
    test '#type' do
      media_type = Webbed::MediaType.new('text/html; foo=bar; lol=rofl')
      media_type.type = 'image'
      
      assert_equal 'image', media_type.type
      assert_equal 'html', media_type.subtype
      assert_equal 'image/html', media_type.mime_type
    end
    
    test '#subtype' do
      media_type = Webbed::MediaType.new('text/html; foo=bar; lol=rofl')
      media_type.subtype = 'xml'
      
      assert_equal 'text', media_type.type
      assert_equal 'xml', media_type.subtype
      assert_equal 'text/xml', media_type.mime_type
    end
    
    test '#parameters' do
      media_type = Webbed::MediaType.new('text/html; foo=bar; lol=rofl')
      media_type.parameters = { 'test' => 'lol' }
      
      assert_equal 'lol', media_type.parameters['test']
    end
    
    test '#to_s' do
      assert_equal 'text/html', Webbed::MediaType.new('text/html').to_s
      
      media_type_string = Webbed::MediaType.new('text/html; foo=bar; lol=rofl').to_s
      assert media_type_string.include?('; lol=rofl')
      assert media_type_string.include?('; foo=bar')
      assert media_type_string.include?('text/html')
    end
    
    test '#vendor_specific?' do
      refute Webbed::MediaType.new('text/html; foo=bar; lol=rofl').vendor_specific?
      assert Webbed::MediaType.new('application/vnd.lol+xml').vendor_specific?
    end
    
    test '#suffix' do
      suffixed = Webbed::MediaType.new('application/atom+xml')
      assert_equal 'xml', suffixed.suffix
      assert_includes suffixed.interpretable_as, 'application/xml'
      assert_includes suffixed.interpretable_as, 'application/atom+xml'
      
      not_suffixed = Webbed::MediaType.new('text/html')
      assert_nil not_suffixed.suffix
      assert_includes not_suffixed.interpretable_as, 'text/html'
    end
    
    test 'equality' do
      json = Webbed::MediaType.new('application/json')
      
      assert_equal Webbed::MediaType.new('application/json'), json
      refute_equal Webbed::MediaType.new('text/html'), json
    end
  end
end