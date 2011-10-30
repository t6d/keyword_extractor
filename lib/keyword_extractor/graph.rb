module KeywordExtractor
  class Graph

    attr_reader :adjacency_matrix

    def self.from_matrix(matrix, directed = true)
      raise ArgumentError, "Expected a matrix" unless
      matrix.kind_of?(Matrix)

      raise ArgumentError, "Expected a quadratic matrix" unless
      matrix.row_size == matrix.column_size

      graph = new(matrix.row_size, directed)
      matrix.each_with_index do |value, row, column|
        graph[row, column] = value
      end
      graph
    end

    def initialize(vertices_count, directed = true)
      @adjacency_matrix = Matrix.build(vertices_count, vertices_count) {0.0}
      @directed = directed
      @labels = {}
    end

    def []=(row, col, value)
      row = determine_index_for_label(row) if row.kind_of?(String)
      col = determine_index_for_label(col) if col.kind_of?(String)

      tmp = *adjacency_matrix
      tmp[row][col] = value.to_f
      tmp[col][row] = value.to_f if undirected?
      @adjacency_matrix = Matrix[*tmp]
      value
    end

    def [](row, col)
      row = determine_index_for_label(row) if row.kind_of?(String)
      col = determine_index_for_label(col) if col.kind_of?(String)

      @adjacency_matrix[row, col]
    end

    def label(vertex_id, label = nil)
      label ? @labels[vertex_id] = label : @labels[vertex_id]
    end

    def edge?(row, column)
      @adjacency_matrix[row, column] != 0.0
    end

    def outdegree(vertex)
      vertex = determine_index_for_label(vertex) if vertex.kind_of?(String)
      0.upto(vertices_count - 1).inject(0) { |sum, index| edge?(vertex, index) ? sum += 1 : sum }
    end

    def indegree(vertex)
      vertex = determine_index_for_label(vertex) if vertex.kind_of?(String)
      0.upto(vertices_count - 1).inject(0) { |sum, index| edge?(index, vertex) ? sum += 1 : sum }
    end

    def degree(vertex)
      outdegree(vertex) + indegree(vertex)
    end

    def vertices_count
      @adjacency_matrix.row_size
    end

    def edges_count
      @adjacency_matrix.inject(0) { |sum, e| e != 0 ? sum += 1 : sum }
    end

    def directed?
      @directed
    end

    def undirected?
      not directed?
    end

    def to_lmi_graph
      lmi_matrix = Array.new(vertices_count) { Array.new(vertices_count, 0.0)}

      adjacency_matrix.each_with_index do |weight, row, col|
        lmi_matrix[row][col] = if edge?(row, col)
          weight * Math.log(weight / (degree(row) * degree(col)).to_f, 2)
        else
          0.0
        end
      end

      lmi_graph = self.class.from_matrix(Matrix[*lmi_matrix], directed?)
      0.upto(vertices_count - 1) do |index|
        lmi_graph.label(index, label(index))
      end
      lmi_graph
    end

    private

      def determine_index_for_label(given_label)
        @labels.each do |index, label|
          return index if label == given_label
        end

        nil
      end

  end
end
