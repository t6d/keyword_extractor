require 'pp'
require 'bundler'
Bundler.require

text = <<-TEXT
  EuRuKo (the European Ruby Conference) is an annual conference which focuses on
  the Ruby programming language, with an informal atmosphere and lots of
  opportunities to listen, to talk, to hack, to have fun and where delegates
  experience distinct and insightful content from speakers of the highest
  calibre.

  EuRuKo is being organised for the past 10 years in cities around Europe by Ruby
  developers for Ruby developers. It's a truly volunteer-based event and like
  Ruby it is fostered by the community. Each year a different european city and
  its local community of Ruby enthusiasts are tasked to host the event and that's
  what makes EuRuKo one of a kind.

  This summer EuRuKo comes to Athens for two days on the 28th and 29th of June.

  We can't wait to see you in Athens this summer!
TEXT

KeywordExtractor::KeywordRanking.perform(text).each do |token|
  puts token.inspect
end
