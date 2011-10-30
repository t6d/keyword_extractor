module KeywordExtraction
  class Word
    include Comparable

    attr_accessor :inflected
    attr_accessor :pos_tag
    attr_accessor :stemmed
    attr_accessor :rank

    def self.from_string(string, separator = "/")
      return nil if string.strip.empty?
      
      inflected, pos_tag = string.split(separator)
      
      new inflected, pos_tag, inflected.stem
    end

    def initialize(inflected, pos_tag, stemmed)
      @inflected  = inflected.to_s.strip
      @pos_tag    = pos_tag.to_s.strip
      @stemmed    = stemmed.to_s.strip
    end

    def <=>(other)
      self.stemmed <=> other.stemmed
    end

    def eql?(other)
      self == other
    end

    def hash
      self.stemmed.hash
    end
    
    def noun?
      !!(self.pos_tag =~ /NN.*/)
    end
    
    def adjective?
      !!(self.pos_tag =~ /JJ.*/)
    end
    
    def noun_or_adjective?
      noun? or adjective?
    end
    
    def inspect
      "Word(#{inflected}, #{pos_tag}, #{stemmed})"
    end

    def to_s
      inflected
    end

  end
end