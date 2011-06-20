require 'addressable/uri'

module Webbed
  # Representation of an HTTP Request.
  # 
  # This class contains the absolute minimum for accessing the different parts
  # of an HTTP Request. Helper modules provide far more functionality.
  class Request
    include GenericMessage
    
    # The Request-URI of the Request.
    #
    # The method automatically converts the new value to an instance of
    # `Addressable::URI` if it is not already one.
    # 
    # @return [Addressable::URI]
    # @note {Webbed::Helpers::RequestURIHelper} aliases this method to `#request_url`.
    attr_reader :request_uri
    
    def request_uri=(request_uri)
      @request_uri = Addressable::URI.parse(request_uri)
    end
    
    # The scheme of the Request.
    # 
    # @return ['http', 'https']
    attr_accessor :scheme
    
    # Creates a new Request.
    # 
    # The method converts the values passed in to their proper types.
    # 
    # @example
    #     Webbed::Request.new('GET', 'http://example.com', {}, '')
    # 
    # @param [Webbed::Method, String] method
    # @param [Addressable::URI, String] request_uri
    # @param [Webbed::Headers, Hash] headers
    # @param [#to_s] entity_body
    # @param [Hash] options the options to create the Request with
    # @option options [#to_s] :http_version (1.1) the HTTP Version of the Request
    # @option options ['http', 'https'] :scheme ('http') the scheme of the Request
    def initialize(method, request_uri, headers, entity_body, options = {})
      self.method       = method
      self.request_uri  = request_uri
      self.headers      = headers
      self.entity_body  = entity_body
      self.http_version = options[:http_version] || 1.1
      self.scheme       = options[:scheme] || 'http'
    end
    
    # The Method of the Request.
    # 
    # @return [Webbed::Method]
    def method(*args)
      return super(*args) unless args.empty?
      @method
    end
    
    # Sets the Method of the Request.
    # 
    # @param [Webbed::Method, String] method
    def method=(method)
      @method = Webbed::Method.lookup(method)
    end
    
    # The Request-Line of the Request as defined in RFC 2616.
    # 
    # @example
    #     request = Webbed::Request.new(['GET', 'http://example.com', {}, ''])
    #     request.request_line # => "GET * HTTP/1.1\r\n"
    # 
    # @return [String]
    def request_line
      "#{method} #{request_uri} #{http_version}\r\n"
    end
    alias :start_line :request_line
    
    include Helpers::MethodHelper
    include Helpers::RequestURIHelper
    include Helpers::RackRequestHelper
    include Helpers::SchemeHelper
    include Helpers::RequestHeadersHelper
    include Helpers::EntityHeadersHelper
  end
end