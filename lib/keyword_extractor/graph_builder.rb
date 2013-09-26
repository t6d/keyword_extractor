module KeywordExtractor
  class GraphBuilder < ComposableOperations::Operation

    processes :edges

    def execute
      graph = KeywordExtractor::Graph.from_labels(labels)
      edges.each do |edge|
        origin, destination = *edge
        graph[origin, destination] += 1
      end
      graph
    end

    protected

      def labels
        edges.flatten.uniq
      end

  end
end
