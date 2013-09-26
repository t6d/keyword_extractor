module KeywordExtractor
  class Tokenization < ComposableOperations::Operation

    processes :sentences

    property :language, default: :en, converts: :to_sym, required: true, accepts: [:en, :de]

    property :decorator, accepts: lambda { |decorator| decorator.respond_to?(:new) }

    def execute
      tokenizer = OpenNLP::Tokenizer.new(model)
      Array(sentences).map do |sentence|
        tokenizer.process(sentence).map { |word| decorator ? decorator.new(word) : word }
      end
    end

    protected

      def model
        case language
        when :en then OpenNLP::English.tokenization_model
        when :de then OpenNLP::German.tokenization_model
        end
      end

  end
end

