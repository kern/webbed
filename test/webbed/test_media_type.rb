require 'test_helper'

class TestMediaType < MiniTest::Unit::TestCase
  def test_initialize_with_only_mime_type
    media_type = Webbed::MediaType.new('text/html')
    
    assert_equal 'text', media_type.type
    assert_equal 'html', media_type.subtype
    assert_equal 'text/html', media_type.mime_type
    assert media_type.parameters.empty?
  end
  
  def test_initialize_with_mime_type_and_parameters
    media_type = Webbed::MediaType.new('text/html; foo=bar; lol=rofl')
    
    assert_equal 'text', media_type.type
    assert_equal 'html', media_type.subtype
    assert_equal 'text/html', media_type.mime_type
    assert_equal 'bar', media_type.parameters['foo']
    assert_equal 'rofl', media_type.parameters['lol']
  end
  
  def test_initialize_with_mime_type_and_weirdly_spaced_parameters
    media_type = Webbed::MediaType.new('text/html;   foo=bar ; lol=rofl')
    
    assert_equal 'text', media_type.type
    assert_equal 'html', media_type.subtype
    assert_equal 'text/html', media_type.mime_type
    assert_equal 'bar', media_type.parameters['foo']
    assert_equal 'rofl', media_type.parameters['lol']
  end
  
  def test_mime_type
    media_type = Webbed::MediaType.new('text/html; foo=bar; lol=rofl')
    media_type.mime_type = 'application/json'
    
    assert_equal 'application', media_type.type
    assert_equal 'json', media_type.subtype
    assert_equal 'application/json', media_type.mime_type
  end
  
  def test_type
    media_type = Webbed::MediaType.new('text/html; foo=bar; lol=rofl')
    media_type.type = 'image'
    
    assert_equal 'image', media_type.type
    assert_equal 'html', media_type.subtype
    assert_equal 'image/html', media_type.mime_type
  end
  
  def test_subtype
    media_type = Webbed::MediaType.new('text/html; foo=bar; lol=rofl')
    media_type.subtype = 'xml'
    
    assert_equal 'text', media_type.type
    assert_equal 'xml', media_type.subtype
    assert_equal 'text/xml', media_type.mime_type
  end
  
  def test_parameters
    media_type = Webbed::MediaType.new('text/html; foo=bar; lol=rofl')
    media_type.parameters = { 'test' => 'lol' }
    
    assert_equal 'lol', media_type.parameters['test']
  end
  
  def test_to_s
    assert_equal 'text/html', Webbed::MediaType.new('text/html').to_s
    assert_equal 'text/html; foo=bar; lol=rofl', Webbed::MediaType.new('text/html; foo=bar; lol=rofl').to_s
  end
  
  def test_vendor_specific
    refute Webbed::MediaType.new('text/html; foo=bar; lol=rofl').vendor_specific?
    assert Webbed::MediaType.new('application/vnd.lol+xml').vendor_specific?
  end
  
  def test_suffix
    suffixed = Webbed::MediaType.new('application/atom+xml')
    assert_equal 'xml', suffixed.suffix
    assert_includes suffixed.interpretable_as, 'application/xml'
    assert_includes suffixed.interpretable_as, 'application/atom+xml'
    
    not_suffixed = Webbed::MediaType.new('text/html')
    assert_nil not_suffixed.suffix
    assert_includes not_suffixed.interpretable_as, 'text/html'
  end
end