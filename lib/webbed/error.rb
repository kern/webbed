module Webbed
  # `Error` is the superclass of all custom exceptions used in Webbed. It
  # allows for exception wrapping.
  #
  # @author Alexander Simon Kern (alex@kernul)
  # @api public
  class Error < StandardError
    # Returns the exception that caused this exception.
    #
    # @return [Exception]
    attr_reader :cause
   
    def initialize(message, cause = $!) 
      super(message)
      @cause = cause
    end 
  end
end
