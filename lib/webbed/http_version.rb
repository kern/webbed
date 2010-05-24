module Webbed
  class HTTPVersion
    
    attr_reader :major, :minor
    
    def initialize(major = 1, minor = 1)
      @major = major
      @minor = minor
    end
    
    def to_s
      "HTTP/#{major}.#{minor}"
    end
    
    def ==(other_version)
      to_s == other_version.to_s
    end
  end
end