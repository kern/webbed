Carpenter.define do
  builder :get_method do
    Webbed::Method.new("GET", :safe => true, :idempotent => true, :allows_request_entity => false, :allows_response_entity => true)
  end

  builder :valid_method do
    Webbed::Method.new("VALID", :safe => true, :idempotent => true, :allows_request_entity => true, :allows_response_entity => true)
  end

  builder :valid_method_2 do
    Webbed::Method.new("VALID", :safe => false, :idempotent => true, :allows_request_entity => false, :allows_response_entity => true)
  end

  builder :invalid_method do
    Webbed::Method.new("INVALID", {})
  end
end
