module KeywordExtractor
  class GraphPrinter

    attr_reader :graph

    def self.print(graph)
      new(graph).print
    end

    def initialize(graph)
      @graph = graph
    end

    def print
      dot = ""

      dot += print_header
      dot += print_elements
      dot += print_footer

      dot
    end

    private

      def print_header
        if graph.directed?
          "digraph g {\n"
        else
          "graph g {\n"
        end
      end

      def print_elements
        elements = ""
        edge     = graph.directed? ? "->" : "--"

        0.upto(graph.vertices_count - 1) do |row|
          elements += "  #{row} [label=\"#{graph.label(row) || row}\"]\n"
          0.upto(graph.vertices_count - 1) do |column|
            elements += "  #{row} #{edge} #{column}\n" if row <= column and graph.edge?(row, column)
          end
          elements += "\n"
        end

        elements
      end

      def print_footer
        "}\n"
      end

  end
end
