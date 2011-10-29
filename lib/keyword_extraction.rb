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
      
      word_list = Set.new
      cooccurrences.each do |cooccurrence, count|
        word_list << cooccurrence.first
        word_list << cooccurrence.last
      end
      word_list = word_list.to_a
      
      graph = Graph.new(word_list.count, false)
      word_list.each_with_index do |word, index|
        graph.label(index, word.stemmed)
      end
      
      cooccurrences.each do |cooccurrence, count|
        graph[cooccurrence.first.stemmed, cooccurrence.last.stemmed] = count
      end
      
      lmi_graph = graph.to_lmi_graph
      ranks     = PageRank.calculate(lmi_graph, count)
      
      word_list.each_with_index do |word, index|
        word.rank = ranks[index]
      end
      
      word_list.sort { |a, b| (a.rank <=> b.rank) * -1 }[0 ... count]
    end

    private

      def ngrams(words, size = 1)
        0.upto(words.length - size) do |index|
          yield words[index ... index + size]
        end
      end

  end
end
