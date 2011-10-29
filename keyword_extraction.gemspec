# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "keyword_extraction/version"

Gem::Specification.new do |s|
  s.name        = "keyword_extraction"
  s.version     = KeywordExtraction::VERSION
  s.authors     = ["Konstantin Tennhard"]
  s.email       = ["me@t6d.de"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "keyword_extraction"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  
  s.add_runtime_dependency "engtagger"
  s.add_runtime_dependency "stemmer"
  
  s.add_development_dependency "rspec"
end
