module KeywordExtractor
  class Token
    include Comparable

    attr_reader :value

    def initialize(value)
      @value = value
      @meta_data = {}
    end

    def <=>(other)
      value <=> other.value
    end

    def hash
      value.hash ^ meta_data.hash
    end

    def [](key)
      @meta_data[key]
    end

    def []=(key, value)
      @meta_data[key] = value
    end

    def inspect
      "%s(%s, %s)" % [self.class.name, value, meta_data.map { |pair| "%s: %s" % pair }.join(', ')]
    end

    def to_s
      value
    end

    alias eql? ==

    protected

      attr_reader :meta_data

  end
end

