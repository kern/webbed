require "parslet"

module Webbed
  module Grammars
    # `Interpreter` combines a parser and a transform into a single object,
    # allowing you to pass them around as a composite.
    #
    # @author Alexander Simon Kern (alex@kernul)
    # @api private
    class Interpreter
      extend Forwardable

      def initialize(parser, transform)
        @parser = parser
        @transform = transform
      end

      def interpret(input, context = {})
        apply(parse(input), context)
      end

      private

      delegate parse: :@parser
      delegate apply: :@transform
    end
  end
end
