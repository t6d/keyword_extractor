module KeywordExtractor
  class SentenceDetection < ComposableOperations::Operation

    processes :text

    property :language, default: :en, converts: :to_sym, required: true, accepts: [:en, :de]

    def execute
      detector = OpenNLP::SentenceDetector.new(model)
      detector.process(text)
    end

    protected

      def model
        case language
        when :en then OpenNLP::English.sentence_detection_model
        when :de then OpenNLP::German.sentence_detection_model
        end
      end

  end
end
