module KeywordExtractor
  class PreProcessingPipeline < ComposableOperations::ComposedOperation

    property :filter
    property :token_decorator, default: Token, required: true

    use KeywordExtractor::SentenceDetection
    use KeywordExtractor::Tokenization, decorator: lambda { token_decorator }
    use KeywordExtractor::POSTagging
    use KeywordExtractor::TokenFilter, patterns: lambda { filter }, attribute: :pos_tag
    use KeywordExtractor::Stemming

  end
end
