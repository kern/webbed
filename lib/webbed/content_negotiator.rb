module Webbed
  class ContentNegotiator
    attr_accessor :ranges

    def initialize(ranges)
      @ranges = ranges
      @ranges_by_precedence ||= @ranges.sort_by do |range|
        [range.precedence, range.quality, sort_order(range)]
      end.reverse
    end

    def negotiate(tags)
      pairs = find_acceptable_pairs(tags)
      highest_quality_pair(pairs)[0]
    end

    private

    def sort_array(range)
      [range.quality, -@ranges.index(range)]
    end

    def find_acceptable_pairs(tags)
      find_all_pairs(tags).select { |tag, range| range && range.acceptable? }
    end

    def find_all_pairs(tags)
      tags.inject({}) do |acc, tag|
        acc[tag] = find_range(tag)
        acc
      end
    end

    def highest_quality_pair(pairs)
      return [nil, nil] if pairs.empty?
      pairs.max_by { |tag, range| [range.quality, sort_order(range)] }
    end

    def find_range(tag)
      @ranges_by_precedence.find { |range| range.include?(tag) }
    end

    def sort_order(range)
      -@ranges.index(range)
    end
  end
end
