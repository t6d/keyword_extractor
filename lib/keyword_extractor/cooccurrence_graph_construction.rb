module KeywordExtractor
  class CooccurrenceGraphConstruction < ComposableOperations::ComposedOperation

    property :window_size, converts: :to_i,
                           default: 2,
                           accepts: lambda { |window_size| window_size >= 0 },
                           required: true

    use CooccurrenceBuilder, window_size: lambda { window_size }
    use GraphBuilder

  end
end

