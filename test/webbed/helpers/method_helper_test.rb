require 'test_helper'

module WebbedTest
  module HelperTest
    class MethodHelperTest < TestCase
      test '#options?' do
        request = Webbed::Request.new('OPTIONS', '*', {}, '')
        
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
      
      test '#get?' do
        request = Webbed::Request.new('GET', '*', {}, '')
        
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
      
      test '#head?' do
        request = Webbed::Request.new('HEAD', '*', {}, '')
        
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
      
      test '#post?' do
        request = Webbed::Request.new('POST', '*', {}, '')
        
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
      
      test '#put?' do
        request = Webbed::Request.new('PUT', '*', {}, '')
        
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
      
      test '#delete?' do
        request = Webbed::Request.new('DELETE', '*', {}, '')
        
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
      
      test '#trace?' do
        request = Webbed::Request.new('TRACE', '*', {}, '')
        
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
      
      test '#connect?' do
        request = Webbed::Request.new('CONNECT', '*', {}, '')
        
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
      
      test '#patch?' do
        request = Webbed::Request.new('PATCH', '*', {}, '')
        
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
  end
end