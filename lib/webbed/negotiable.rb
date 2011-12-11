module Webbed
  module Negotiable
    def precedence
      0
    end
    
    def quality
      0
    end
    
    def acceptable?
      quality != 0
    end
  end
end