require 'bundler'
Bundler.require

text = %q{The Occupy Wall Street movement began in Zuccotti Park on a glorious
mid-September Saturday and, so far, many of its larger marches have taken
place in the warmth of New York's Indian summer. But winter has been looming,
and on Saturday, just a couple days before Halloween, the protesters got a
preview of what they're in for.}

puts KeywordExtractor.print_cooccurrence_graph(text)
