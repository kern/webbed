module Webbed
  # `URLRecreator` recreates the URL of the request.
  #
  # @author Alex Kern
  # @api private
  class URLRecreator
    # Creates a new URL recreator.
    #
    # @param [Request] request the request from which to recreate the URL
    def initialize(request)
      @request = request
    end

    # Returns the recreated URL.
    #
    # If the request URI is an absolute path, this method returns the request
    # URI. Otherwise, if the Host header is present, this method returns a
    # modified request URI that uses the Host header and whether the request is
    # secure. If the Host header is not present, this method returns the
    # request URI untouched.
    # 
    # @return [Addressable::URI]
    def recreate
      request_uri.dup.tap do |r|
        if !request_uri_has_host? && host_header
          r.scheme = scheme
          r.host = host_header
        end
      end
    end

    private

    # Returns the request URI.
    #
    # @return [Addressable::URI]
    def request_uri
      @request.request_uri
    end

    # Returns the value of the Host header.
    #
    # @return [String, nil]
    def host_header
      @request.headers["Host"]
    end

    # Returns whether or not the request is secure.
    #
    # @return [Boolean]
    def secure?
      @request.secure?
    end

    # Returns the scheme of the request.
    #
    # @return ["http", "https"]
    def scheme
      secure? ? "https" : "http"
    end

    # Returns whether or not the request URI has a host.
    #
    # @return [Boolean]
    def request_uri_has_host?
      request_uri.host
    end
  end
end
