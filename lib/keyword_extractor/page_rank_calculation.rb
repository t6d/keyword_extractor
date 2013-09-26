module KeywordExtractor
  class PageRankCalculation < ComposableOperations::Operation

    processes :graph

    def execute
      lmi_graph = graph.to_lmi_graph
      ranks = KeywordExtractor::PageRank.calculate(lmi_graph)

      tokens = ranks.map.with_index do |rank, vertex_index|
        token = graph.label(vertex_index)
        token[:rank] = rank
        token
      end

      tokens.sort { |a, b| a[:rank] <=> b[:rank] }
    end

  end
end

