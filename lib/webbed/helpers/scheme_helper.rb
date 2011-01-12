module Webbed
  module Helpers
    module SchemeHelper
      def secure?
        scheme == 'https'
      end
    end
  end
end