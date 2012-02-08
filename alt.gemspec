# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alt/version"

Gem::Specification.new do |s|
  s.name        = "alt"
  s.version     = Alt::VERSION
  s.authors     = ["Sam Aarons"]
  s.email       = ["samaarons@gmail.com"]
  s.homepage    = "http://www.alt-lang.org"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "alt"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "kpeg"
end