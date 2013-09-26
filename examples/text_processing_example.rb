require_relative 'example_helper'

class Printer < ComposableOperations::Operation

  processes :tagged_sentences

  property :output, default: lambda { STDOUT },
                    required: true,
                    accepts: lambda { |o| [:puts, :write].all? { |m| o.respond_to?(m) } }

  def execute
    tagged_sentences.each_with_index do |tagged_sentence, index|
      write "%d. Sentence: " % (index + 1)
      write tagged_sentence.map { |token| token ? "%s(%s)/%s" % [token, token[:stem], token[:pos_tag]] : '-' }.join(" ")
      puts
    end
  end

  def write(*args)
    output.write(*args)
  end

  def puts(*args)
    output.puts(*args)
  end

end

text = <<-TEXT
  Hello World! This is a test. This is another test sentence. Let's see how
  pipeline performs! Great, isn't it?
TEXT

tagged_sentences = KeywordExtractor::PreProcessingPipeline.perform(text, filter: [/^NN/, /^VB/])
Printer.perform(tagged_sentences)

