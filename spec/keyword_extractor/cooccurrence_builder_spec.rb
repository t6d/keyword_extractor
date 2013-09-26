require 'spec_helper'

describe KeywordExtractor::CooccurrenceBuilder do

  let(:tokens) { ["just", nil, nil, "some", nil, "random", nil, "words", nil, nil, nil, "with", "gaps"] }

  let(:window_size) { 0 }

  subject(:cooccurrence_builder) do
    described_class.new(tokens, window_size: window_size)
  end

  context "when the window size is 1" do

    let(:window_size) { 1 }

    it "should return the following cooccurrences: (with, gaps), (gaps, with)" do
      cooccurrence_builder.should succeed_to_perform.and_return([%w[with gaps], %w[gaps with]])
    end

  end

  context "when the window size is 2" do

    let(:window_size) { 2 }

    it "should return the following cooccurrences: (with, gaps), (gaps, with)" do
      cooccurrence_builder.should succeed_to_perform.and_return([
        %w[some random],
        %w[random some],
        %w[random words],
        %w[words random],
        %w[with gaps],
        %w[gaps with]
      ])
    end

  end

end
