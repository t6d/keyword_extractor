# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "keyword_extractor/version"

Gem::Specification.new do |s|
  s.name        = "keyword_extractor"
  s.version     = KeywordExtractor::VERSION
  s.authors     = ["Konstantin Tennhard"]
  s.email       = ["me@t6d.de"]
  s.homepage    = ""
  s.summary     = %q{Keyword Extractor extracts the most important words in a text}
  s.platform    = "java"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "opennlp"
  s.add_dependency "composable_operations", "~> 0.4"

  s.add_development_dependency "rspec", '~> 2.13'
  s.add_development_dependency "guard-rspec"
end
