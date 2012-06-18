require "parslet"

module Webbed
  module Grammars
    # `Parser` is a wrapper around Parslet parsers that raises a Webbed-specific
    # error class instead of the standard Parslet one.
    #
    # @author Alexander Simon Kern (alex@kernul.com)
    # @api private
    class Parser < Parslet::Parser
      def parse(io, options = {})
        super(io, options)
      rescue Parslet::ParseFailed => e
        raise ParseFailed, e.message
      end
    end
  end
end
