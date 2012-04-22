module Webbed
  # `Error` is the superclass of all custom exceptions used in Webbed. It
  # allows for exception wrapping.
  #
  # @author Alex Kern
  # @api public
  class Error < StandardError
    attr_reader :cause
   
    def initialize(message = nil, cause = $!) 
      super(message)
      @cause = cause
    end 
  end
end
