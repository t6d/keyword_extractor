module KeywordExtractor
  class CooccurrenceBuilder < ComposableOperations::Operation

    processes :tokens

    property :window_size, converts: :to_i,
                           accepts: lambda { |window_size| window_size >= 0 },
                           required: true

    def execute
      cooccurrences = []

      tokens = Array(self.tokens).flatten
      tokens.each_with_index do |token, index|
        (index - window_size .. index + window_size).each do |pointer|
          next if pointer == index
          next if pointer < 0 or pointer >= tokens.length
          next if tokens[index].nil? or tokens[pointer].nil?

          cooccurrences << [tokens[index], tokens[pointer]]
        end
      end

      cooccurrences
    end

  end
end

