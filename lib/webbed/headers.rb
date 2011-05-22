module Webbed
  # Representation of HTTP headers.
  # 
  # This class is stolen directly from Rack.
  class Headers < Hash
    def self.new(hash={})
      Headers === hash ? hash : super(hash)
    end
    
    def initialize(hash={})
      super()
      @names = {}
      hash.each { |k, v| self[k] = v }
    end
    
    def each
      super do |k, v|
        yield(k, v.respond_to?(:to_ary) ? v.to_ary.join("\n") : v)
      end
    end
    
    def to_hash
      inject({}) do |hash, (k,v)|
        if v.respond_to? :to_ary
          hash[k] = v.to_ary.join("\n")
        else
          hash[k] = v
        end
        hash
      end
    end
    
    def [](k)
      super(@names[k]) if @names[k]
      super(@names[k.downcase])
    end
    
    def []=(k, v)
      delete k
      @names[k] = @names[k.downcase] = k
      super k, v
    end
    
    def delete(k)
      canonical = k.downcase
      result = super @names.delete(canonical)
      @names.delete_if { |name,| name.downcase == canonical }
      result
    end
    
    def include?(k)
      @names.include?(k) || @names.include?(k.downcase)
    end
    
    alias_method :has_key?, :include?
    alias_method :member?, :include?
    alias_method :key?, :include?
    
    def merge!(other)
      other.each { |k, v| self[k] = v }
      self
    end
    
    def merge(other)
      hash = dup
      hash.merge! other
    end
    
    def replace(other)
      clear
      other.each { |k, v| self[k] = v }
      self
    end
    
    def to_s
      map do |field_name, field_content|
        "#{field_name}: #{field_content}\r\n"
      end.join
    end
  end
end