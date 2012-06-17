require "parslet"
require "webbed/invalid_format"

module Webbed
  module Grammars
    class Interpreter
      extend Forwardable

      def initialize(parser, transform)
        @parser = parser
        @transform = transform
      end

      def interpret(input, context = {})
        apply(parse(input), context)
      rescue Parslet::ParseFailed => e
        raise InvalidFormat, e.message
      end

      private

      delegate parse: :@parser
      delegate apply: :@transform
    end
  end
end
