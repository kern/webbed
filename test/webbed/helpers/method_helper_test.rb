require 'test_helper'

class MethodHelperTest < MiniTest::Unit::TestCase
  def test_options
    request = Webbed::Request.new(['OPTIONS', '*', {}, ''])
    
    assert request.options?
    refute request.get?
    refute request.head?
    refute request.post?
    refute request.put?
    refute request.delete?
    refute request.trace?
    refute request.connect?
    refute request.patch?
    assert request.safe?
    assert request.idempotent?
  end
  
  def test_get
    request = Webbed::Request.new(['GET', '*', {}, ''])
    
    refute request.options?
    assert request.get?
    refute request.head?
    refute request.post?
    refute request.put?
    refute request.delete?
    refute request.trace?
    refute request.connect?
    refute request.patch?
    assert request.safe?
    assert request.idempotent?
  end
  
  def test_head
    request = Webbed::Request.new(['HEAD', '*', {}, ''])
    
    refute request.options?
    refute request.get?
    assert request.head?
    refute request.post?
    refute request.put?
    refute request.delete?
    refute request.trace?
    refute request.connect?
    refute request.patch?
    assert request.safe?
    assert request.idempotent?
  end
  
  def test_post
    request = Webbed::Request.new(['POST', '*', {}, ''])
    
    refute request.options?
    refute request.get?
    refute request.head?
    assert request.post?
    refute request.put?
    refute request.delete?
    refute request.trace?
    refute request.connect?
    refute request.patch?
    refute request.safe?
    refute request.idempotent?
  end
  
  def test_put
    request = Webbed::Request.new(['PUT', '*', {}, ''])
    
    refute request.options?
    refute request.get?
    refute request.head?
    refute request.post?
    assert request.put?
    refute request.delete?
    refute request.trace?
    refute request.connect?
    refute request.patch?
    refute request.safe?
    assert request.idempotent?
  end
  
  def test_delete
    request = Webbed::Request.new(['DELETE', '*', {}, ''])
    
    refute request.options?
    refute request.get?
    refute request.head?
    refute request.post?
    refute request.put?
    assert request.delete?
    refute request.trace?
    refute request.connect?
    refute request.patch?
    refute request.safe?
    assert request.idempotent?
  end
  
  def test_trace
    request = Webbed::Request.new(['TRACE', '*', {}, ''])
    
    refute request.options?
    refute request.get?
    refute request.head?
    refute request.post?
    refute request.put?
    refute request.delete?
    assert request.trace?
    refute request.connect?
    refute request.patch?
    assert request.safe?
    assert request.idempotent?
  end
  
  def test_connect
    request = Webbed::Request.new(['CONNECT', '*', {}, ''])
    
    refute request.options?
    refute request.get?
    refute request.head?
    refute request.post?
    refute request.put?
    refute request.delete?
    refute request.trace?
    assert request.connect?
    refute request.patch?
    refute request.safe?
    refute request.idempotent?
  end
  
  def test_patch
    request = Webbed::Request.new(['PATCH', '*', {}, ''])
    
    refute request.options?
    refute request.get?
    refute request.head?
    refute request.post?
    refute request.put?
    refute request.delete?
    refute request.trace?
    refute request.connect?
    assert request.patch?
    refute request.safe?
    refute request.idempotent?
  end
end