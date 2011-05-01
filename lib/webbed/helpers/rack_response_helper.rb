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
      # The array has the same format as the one that you use in order to create
      # a Response.
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