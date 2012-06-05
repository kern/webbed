module Webbed
  # `URLRecreator` recreates the URL of the request.
  #
  # @author Alex Kern
  # @api private
  class URLRecreator
    extend Forwardable

    delegate [:target, :secure?] => :@request

    # Creates a new URL recreator.
    #
    # @param [Request] request the request from which to recreate the URL
    def initialize(request)
      @request = request
    end

    # Returns the recreated URL.
    #
    # If the target is an absolute path, this method returns the target.
    # Otherwise, if the Host header is present, this method returns a modified
    # target that uses the Host header and whether the request is secure. If the
    # Host header is not present, this method returns the target untouched.
    # 
    # @return [Addressable::URI]
    def recreate
      target.dup.tap do |r|
        if !target_has_host? && host_header
          r.scheme = scheme
          r.host = host_header
        end
      end
    end

    private

    # Returns the value of the Host header.
    #
    # @return [String, nil]
    def host_header
      @request.headers["Host"]
    end

    # Returns the scheme of the request.
    #
    # @return ["http", "https"]
    def scheme
      secure? ? "https" : "http"
    end

    # Returns whether or not the request's target has a host.
    #
    # @return [Boolean]
    def target_has_host?
      target.host
    end
  end
end
