require "parslet"
require "webbed/invalid_format"

module Webbed
  module Grammars
    class Interpreter
      def initialize(parser, transform)
        @parser = parser
        @transform = transform
      end

      def interpret(input)
        transform(parse(input))
      rescue Parslet::ParseFailed => e
        raise InvalidFormat, e.message
      end

      private

      def parse(input)
        @parser.parse(input)
      end

      def transform(input)
        @transform.apply(input)
      end
    end
  end
end
