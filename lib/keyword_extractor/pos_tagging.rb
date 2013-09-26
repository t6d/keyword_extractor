module KeywordExtractor
  class POSTagging < ComposableOperations::Operation

    processes :tokenized_sentences

    property :language, default: :en, converts: :to_sym, required: true, accepts: [:en, :de]

    def execute
      tagger = OpenNLP::POSTagger.new(model)
      tokenized_sentences.each do |tokenized_sentence|
        tagger.process(tokenized_sentence).each_with_index do |tag, index|
          tokenized_sentence[index][:pos_tag] = tag
        end
      end

      tokenized_sentences
    end

    protected

      def model
        case language
        when :en then OpenNLP::English.pos_tagging_model
        when :de then OpenNLP::German.pos_tagging_model
        end
      end

  end
end

