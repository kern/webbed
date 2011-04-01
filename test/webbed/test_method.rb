require 'test_helper'

class TestMethod < MiniTest::Unit::TestCase
  def test_initialize_without_options
    fake = Webbed::Method.new('FAKE')
    
    assert_equal 'FAKE', fake.to_s
    refute fake.safe?
    refute fake.idempotent?
    assert_includes fake.allowable_entities, :request
    assert_includes fake.allowable_entities, :response
  end
  
  def test_initialize_safe
    fake = Webbed::Method.new('FAKE', :safe => true)
    assert fake.safe?
    assert fake.idempotent?
  end
  
  def test_initialize_idempotent
    fake = Webbed::Method.new('FAKE', :idempotent => true)
    refute fake.safe?
    assert fake.idempotent?
  end
  
  def test_initialize_unsafe
    fake = Webbed::Method.new('FAKE', :safe => false)
    refute fake.safe?
    refute fake.idempotent?
  end
  
  def test_initialize_headers_only
    fake = Webbed::Method.new('FAKE', :allowable_entities => [])
    refute_includes fake.allowable_entities, :request
    refute_includes fake.allowable_entities, :response
  end
  
  def test_initialize_response_entity_only
    fake = Webbed::Method.new('FAKE', :allowable_entities => [:response])
    refute_includes fake.allowable_entities, :request
    assert_includes fake.allowable_entities, :response
  end
  
  def test_initialize_two_entity
    fake = Webbed::Method.new('FAKE', :allowable_entities => [:request, :response])
    assert_includes fake.allowable_entities, :request
    assert_includes fake.allowable_entities, :response
  end
  
  def test_cached
    assert_same Webbed::Method::OPTIONS, Webbed::Method.new('OPTIONS')
    assert_same Webbed::Method::GET, Webbed::Method.new('GET')
    assert_same Webbed::Method::HEAD, Webbed::Method.new('HEAD')
    assert_same Webbed::Method::POST, Webbed::Method.new('POST')
    assert_same Webbed::Method::PUT, Webbed::Method.new('PUT')
    assert_same Webbed::Method::DELETE, Webbed::Method.new('DELETE')
    assert_same Webbed::Method::TRACE, Webbed::Method.new('TRACE')
    assert_same Webbed::Method::CONNECT, Webbed::Method.new('CONNECT')
    assert_same Webbed::Method::PATCH, Webbed::Method.new('PATCH')
  end
  
  def test_equal
    refute_equal Webbed::Method::GET, Webbed::Method::POST
  end
  
  def test_cached_options
    method = Webbed::Method::OPTIONS
    
    assert_equal 'OPTIONS', method.to_s
    assert method.safe?
    assert method.idempotent?
    refute_includes method.allowable_entities, :request
    assert_includes method.allowable_entities, :response
  end
  
  def test_cached_get
    method = Webbed::Method::GET
    
    assert_equal 'GET', method.to_s
    assert method.safe?
    assert method.idempotent?
    refute_includes method.allowable_entities, :request
    assert_includes method.allowable_entities, :response
  end
  
  def test_cached_head
    method = Webbed::Method::HEAD
    
    assert_equal 'HEAD', method.to_s
    assert method.safe?
    assert method.idempotent?
    refute_includes method.allowable_entities, :request
    refute_includes method.allowable_entities, :response
  end
  
  def test_cached_post
    method = Webbed::Method::POST
    
    assert_equal 'POST', method.to_s
    refute method.safe?
    refute method.idempotent?
    assert_includes method.allowable_entities, :request
    assert_includes method.allowable_entities, :response
  end
  
  def test_cached_put
    method = Webbed::Method::PUT
    
    assert_equal 'PUT', method.to_s
    refute method.safe?
    assert method.idempotent?
    assert_includes method.allowable_entities, :request
    assert_includes method.allowable_entities, :response
  end
  
  def test_cached_delete
    method = Webbed::Method::DELETE
    
    assert_equal 'DELETE', method.to_s
    refute method.safe?
    assert method.idempotent?
    refute_includes method.allowable_entities, :request
    assert_includes method.allowable_entities, :response
  end
  
  def test_cached_trace
    method = Webbed::Method::TRACE
    
    assert_equal 'TRACE', method.to_s
    assert method.safe?
    assert method.idempotent?
    refute_includes method.allowable_entities, :request
    assert_includes method.allowable_entities, :response
  end
  
  def test_cached_connect
    method = Webbed::Method::CONNECT
    
    assert_equal 'CONNECT', method.to_s
    refute method.safe?
    refute method.idempotent?
    assert_includes method.allowable_entities, :request
    assert_includes method.allowable_entities, :response
  end
  
  def test_cached_patch
    method = Webbed::Method::PATCH
    
    assert_equal 'PATCH', method.to_s
    refute method.safe?
    refute method.idempotent?
    assert_includes method.allowable_entities, :request
    assert_includes method.allowable_entities, :response
  end
end