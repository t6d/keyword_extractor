module KeywordExtractor
  class Stemming < ComposableOperations::Operation

    processes :tokens

    def execute
      Array(tokens).flatten.each do |token|
        next if token.nil?
        token[:stem] = PorterStemmer.stem(token.to_s.downcase)
      end

      tokens
    end

  end
end

