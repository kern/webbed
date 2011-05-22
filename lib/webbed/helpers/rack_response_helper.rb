module Webbed
  module Helpers
    # Response helper for converting Responses into Rack response arrays
    module RackResponseHelper
      # Converts the Response to a Rack response array
      # 
      # The array has the same format as that defined in the Rack specification.
      # 
      # @return [Array]
      # @note Due to limitations in Rack, Reason Phrases are not included in the
      #   array.
      def to_rack
        if entity_body.respond_to?(:each)
          [status_code.to_i, headers, entity_body]
        else
          [status_code.to_i, headers, [entity_body]]
        end
      end
      
      # Converts the Response to an array
      # 
      # The array has a similar format to the format defined in the Rack specification with some modifications:
      # 
      # 1. The Reason Phrase is included with the Status Code.
      # 2. The Entity Body does not need to respond to `#each`.
      # 
      # @return [Array]
      # @note This will *not* return a Rack-compatible response array.
      # @see Response#initialize
      def to_a
        ["#{status_code} #{reason_phrase}", headers, entity_body]
      end
    end
  end
end