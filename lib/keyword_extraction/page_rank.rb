module KeywordExtraction
  class PageRank

    def self.calculate(graph, iterations = 100, damping_factor = 0.85, initial_rank = 0.25)
      rank           = Vector[*([initial_rank] * graph.vertices_count)]
      damping_vector = Vector[*([(1.0 - damping_factor) / graph.vertices_count] * graph.vertices_count)]
      damping_matrix = (damping_factor * graph.adjacency_matrix.stochastify).transpose

      1.upto(iterations) do
        rank = damping_vector + damping_matrix * rank
      end

      rank
    end

  end
end
