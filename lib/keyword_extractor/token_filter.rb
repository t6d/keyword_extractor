module KeywordExtractor
  class TokenFilter < ComposableOperations::Operation

    processes :sentences

    property :patterns, converts: lambda { |patterns| Array(patterns) }

    property :attribute

    def execute
      return sentences if patterns.empty?

      sentences.map do |sentence|
        sentence.map { |token| match?(token) ? token : nil }
      end
    end

    protected

      def match?(token)
        patterns.any? do |pattern|
          pattern === (attribute ? token[attribute] : token.to_s)
        end
      end

  end
end
