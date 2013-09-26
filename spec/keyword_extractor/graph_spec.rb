require 'spec_helper'

describe KeywordExtractor::Graph do

  context "with 3 labeled vertices: a, b, and c" do

    subject(:graph) { described_class.from_labels(%w[a b c]) }

    context "with an edge from a to be with weight 2.5" do

      before do
        graph["a", "b"] += 2.5
      end

      it "should have one edge" do
        graph.edges_count.should be == 1
      end

      specify "the first vertex, vertex a, should have an outdegree of 1" do
        graph.outdegree(0).should be == 1
        graph.outdegree("a").should be == 1
      end

      specify "the second vertex, vertex b, should have an indegree of 1" do
        graph.indegree(1).should be == 1
        graph.indegree("b").should be == 1
      end

      specify "the edge should exist and have a weight of 2.5" do
        graph.edge?(0, 1).should be
        graph.edge?("a", "b").should be

        graph[0, 1].should be == 2.5
        graph["a", "b"].should be == 2.5
      end

    end

  end

end
