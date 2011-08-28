module Webbed
  module Negotiable
    def precedence
      0
    end
    
    def quality
      0
    end
    
    def order
      0
    end
    
    def precedence_sort_array
      [precedence, quality, -order]
    end
    
    def quality_sort_array
      [quality, -order]
    end
  end
end