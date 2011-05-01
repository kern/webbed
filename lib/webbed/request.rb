require 'addressable/uri'

module Webbed
  # Representation of an HTTP Request
  # 
  # This class contains the absolute minimum for accessing the different parts
  # of an HTTP Request. Helper modules provide far more functionality.
  class Request
    include GenericMessage
    
    # The Request-URI of the Request
    #
    # The method automatically converts the new value to an instance of
    # `Addressable::URI` if it is not already one.
    # 
    # @return [Addressable::URI]
    # @note {Helpers::RequestURIHelper} aliases this method to `#request_url`.
    attr_reader :request_uri
    
    def request_uri=(new_request_uri)
      @request_uri = Addressable::URI.parse(new_request_uri)
    end
    
    # The scheme of the Request
    # 
    # @return ['http', 'https']
    attr_accessor :scheme
    
    # Creates a new Request
    # 
    # The attributes of the Request are passed in as an array. In order, they
    # go:
    # 
    # 1. Method
    # 2. Request-URI
    # 3. Headers
    # 4. Entity Body
    # 
    # The method converts the values passed in to their proper types.
    # 
    # @example
    #     Webbed::Request.new(['GET', 'http://example.com', {}, ''])
    # 
    # @param request_array [Array]
    # @param options [Array] the options to create the Request with
    # @option options :http_version [#to_s] (1.1) the HTTP-Version of the
    #   Request
    # @option options :scheme ['http', 'https'] ('http') the scheme of the
    #   Request
    def initialize(request_array, options = {})
      self.method       = request_array[0]
      self.request_uri  = request_array[1]
      self.headers      = request_array[2]
      self.entity_body  = request_array[3]
      self.http_version = options.delete(:http_version) || 1.1
      self.scheme       = options.delete(:scheme) || 'http'
    end
    
    # The {Method} of the Request
    # 
    # @return [Method]
    def method(*args)
      return super(*args) unless args.empty?
      @method
    end
    
    # Sets the {Method} of the Request
    # 
    # @param new_method [Method]
    def method=(new_method)
      @method = Webbed::Method.new(new_method)
    end
    
    # The Request-Line of the Request as defined in RFC 2616
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