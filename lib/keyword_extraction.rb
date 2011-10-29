require 'bundler/setup'

require 'matrix'
require 'core_ext/matrix'

require 'engtagger'
require 'stemmer'

require 'keyword_extraction/word'
require 'keyword_extraction/graph'
require 'keyword_extraction/page_rank'

module KeywordExtraction
  class << self

    def calculate_word_frequencies(words)
      word_counts = Hash.new(0)
      words.each { |word| word_counts[word] += 1 }
      word_counts
    end

    def calculate_cooccurences(words)
      cooccurences = Hash.new(0)

      ngrams(words, 3) do |ngram|
        [
          [ngram[0], ngram[1]].sort,
          [ngram[0], ngram[2]].sort,
          [ngram[1], ngram[2]].sort
        ].uniq.each do |cooccurence|
          cooccurences[cooccurence] += 1
        end
      end

      cooccurences
    end
    
    def calculate_most_important_words(words, count = 5)
      cooccurrences = calculate_cooccurences(words)
      
      stems = Set.new
      cooccurrences.each do |cooccurrence, count|
        stems << cooccurrence.first.stemmed
        stems << cooccurrence.last.stemmed
      end
      stems = stems.to_a
      
      graph = Graph.new(stems.count, false)
      stems.each_with_index do |stem, index|
        graph.label(index, stem)
      end
      
      cooccurrences.each do |cooccurrence, count|
        graph[cooccurrence.first.stemmed, cooccurrence.last.stemmed] = count
      end
      
      lmi_graph = graph.to_lmi_graph
      ranks     = PageRank.calculate(lmi_graph, count)
      
      ranked_stems = stems.zip(ranks).sort { |a,b| (a.last <=> b.last) * -1 }.map { |word, rank| "#{word} (#{rank})"}
      ranked_stems[0 ... count]
    end

    private

      def ngrams(words, size = 1)
        0.upto(words.length - size) do |index|
          yield words[index ... index + size]
        end
      end

  end
end
