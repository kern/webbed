module Webbed
  class ContentNegotiator
    attr_accessor :ranges
    
    def initialize(ranges)
      @ranges = ranges
    end
    
    def negotiate(tags)
      return nil if tags.empty?
      
      sorted_ranges = @ranges.sort do |range0, range1|
        range1.precedence_sort_array <=> range0.precedence_sort_array
      end
      
      pairs = tags.inject([]) do |acc, tag|
        range = sorted_ranges.find { |range| range.include?(tag) }
        acc.push([tag, range]) if range && range.quality != 0
        acc
      end
      
      return nil if pairs.empty?
      
      pairs.max do |pair0, pair1|
        range0 = pair0[1]
        range1 = pair1[1]
        
        range0.quality_sort_array <=> range1.quality_sort_array
      end.first
    end
    
    private
    
  end
end