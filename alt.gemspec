# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alt/version"

Gem::Specification.new do |s|
  s.name        = "alt"
  s.version     = Alt::VERSION
  s.authors     = ["Sam Aarons", "Archibong Archbong", "Hai Lin", "Ethan Nam", "Zhikun Ma"]
  s.email       = ["samaarons@gmail.com", "aarchibong@gmail.com", "hl2656@columbia.edu", "ethan.s.nam@gmail.com", "zm2181@columbia.edu"]
  s.homepage    = "http://www.alt-lang.org"
  s.summary     = "alt is a functional(-ish) scripting language"
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "alt"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "kpeg"
  s.add_development_dependency "rake"
end