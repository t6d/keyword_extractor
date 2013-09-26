module KeywordExtractor
  class KeywordRanking < ComposableOperations::ComposedOperation

    class StemmedWord < KeywordExtractor::Token

      def <=>(other)
        self[:stem] <=> other[:stem]
      end

      def hash
        self[:stem].hash
      end

    end


    use PreProcessingPipeline, filter: [/^NN/, /^JJ/], token_decorator: StemmedWord
    use CooccurrenceGraphConstruction
    use PageRankCalculation

  end
end

