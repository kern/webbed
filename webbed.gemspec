# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "webbed/version"

Gem::Specification.new do |s|
  s.name        = "webbed"
  s.version     = Webbed::VERSION
  s.authors     = ["Alexander Kern"]
  s.email       = ["alex@kernul.com"]
  s.homepage    = "http://github.com/CapnKernul/webbed"
  s.summary     = %q{Take control of HTTP.}
  s.description = %q{Sane library for manipulating HTTP messages.}

  s.rubyforge_project = "webbed"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "addressable", "~> 2.2"
  s.add_dependency "treetop", "~> 1.4"

  s.add_development_dependency "rspec", "~> 2.7"
  s.add_development_dependency "fuubar", "0.0.6"
  s.add_development_dependency "capybara", "~> 1.1"
end
