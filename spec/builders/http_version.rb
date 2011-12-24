Carpenter.define do
  builder :http_version_1_1 do
    Webbed::HTTPVersion.new("HTTP/1.1")
  end

  builder :http_version_1_0 do
    Webbed::HTTPVersion.new("HTTP/1.0")
  end

  builder :invalid_http_version do
    Webbed::HTTPVersion.new("HTTP/1")
  end
end
