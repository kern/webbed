require 'test_helper'

module WebbedTest
  class MethodTest < TestCase
    test '#initialize without options' do
      fake = Webbed::Method.new('FAKE')
      
      assert_equal 'FAKE', fake.to_s
      refute fake.safe?
      refute fake.idempotent?
      assert_includes fake.allowable_entities, :request
      assert_includes fake.allowable_entities, :response
    end
    
    test '#initialize a safe Method' do
      fake = Webbed::Method.new('FAKE', :safe => true)
      assert fake.safe?
      assert fake.idempotent?
    end
    
    test '#initialize an idempotent Method' do
      fake = Webbed::Method.new('FAKE', :idempotent => true)
      refute fake.safe?
      assert fake.idempotent?
    end
    
    test '#initialize an unsafe Method' do
      fake = Webbed::Method.new('FAKE', :safe => false)
      refute fake.safe?
      refute fake.idempotent?
    end
    
    test '#initialize a headers-only Method' do
      fake = Webbed::Method.new('FAKE', :allowable_entities => [])
      refute_includes fake.allowable_entities, :request
      refute_includes fake.allowable_entities, :response
    end
    
    test '#initialize a response-entity-only Method' do
      fake = Webbed::Method.new('FAKE', :allowable_entities => [:response])
      refute_includes fake.allowable_entities, :request
      assert_includes fake.allowable_entities, :response
    end
    
    test '#initialize a two-entity Method' do
      fake = Webbed::Method.new('FAKE', :allowable_entities => [:request, :response])
      assert_includes fake.allowable_entities, :request
      assert_includes fake.allowable_entities, :response
    end
    
    test 'cached Methods' do
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
    
    test 'equality' do
      fake = Webbed::Method.new('FAKE')
      
      assert_equal Webbed::Method.new('FAKE'), fake
      refute_equal Webbed::Method::POST, fake
    end
    
    test 'OPTIONS' do
      method = Webbed::Method::OPTIONS
      
      assert_equal 'OPTIONS', method.to_s
      assert method.safe?
      assert method.idempotent?
      refute_includes method.allowable_entities, :request
      assert_includes method.allowable_entities, :response
    end
    
    test 'GET' do
      method = Webbed::Method::GET
      
      assert_equal 'GET', method.to_s
      assert method.safe?
      assert method.idempotent?
      refute_includes method.allowable_entities, :request
      assert_includes method.allowable_entities, :response
    end
    
    test 'HEAD' do
      method = Webbed::Method::HEAD
      
      assert_equal 'HEAD', method.to_s
      assert method.safe?
      assert method.idempotent?
      refute_includes method.allowable_entities, :request
      refute_includes method.allowable_entities, :response
    end
    
    test 'POST' do
      method = Webbed::Method::POST
      
      assert_equal 'POST', method.to_s
      refute method.safe?
      refute method.idempotent?
      assert_includes method.allowable_entities, :request
      assert_includes method.allowable_entities, :response
    end
    
    test 'PUT' do
      method = Webbed::Method::PUT
      
      assert_equal 'PUT', method.to_s
      refute method.safe?
      assert method.idempotent?
      assert_includes method.allowable_entities, :request
      assert_includes method.allowable_entities, :response
    end
    
    test 'DELETE' do
      method = Webbed::Method::DELETE
      
      assert_equal 'DELETE', method.to_s
      refute method.safe?
      assert method.idempotent?
      refute_includes method.allowable_entities, :request
      assert_includes method.allowable_entities, :response
    end
    
    test 'TRACE' do
      method = Webbed::Method::TRACE
      
      assert_equal 'TRACE', method.to_s
      assert method.safe?
      assert method.idempotent?
      refute_includes method.allowable_entities, :request
      assert_includes method.allowable_entities, :response
    end
    
    test 'CONNECT' do
      method = Webbed::Method::CONNECT
      
      assert_equal 'CONNECT', method.to_s
      refute method.safe?
      refute method.idempotent?
      assert_includes method.allowable_entities, :request
      assert_includes method.allowable_entities, :response
    end
    
    test 'PATCH' do
      method = Webbed::Method::PATCH
      
      assert_equal 'PATCH', method.to_s
      refute method.safe?
      refute method.idempotent?
      assert_includes method.allowable_entities, :request
      assert_includes method.allowable_entities, :response
    end
  end
end