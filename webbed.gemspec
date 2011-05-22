# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'webbed/version'

Gem::Specification.new do |s|
  s.name        = 'webbed'
  s.version     = Webbed::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alexander Kern']
  s.email       = ['alex@kernul.com']
  s.homepage    = 'http://github.com/CapnKernul/webbed'
  s.summary     = 'Take control of HTTP.'
  s.description = 'Sane library for manipulating HTTP messages.'
  
  s.rubyforge_project = 'webbed'
  
  s.add_dependency 'addressable'
  
  s.add_development_dependency 'minitest', '~> 2.0'
  s.add_development_dependency 'mocha'
  # s.add_development_dependency 'guard-minitest'
  s.add_development_dependency 'ansi'
  s.add_development_dependency 'growl'
  s.add_development_dependency 'ruby-progressbar'
  s.add_development_dependency 'maruku'
  s.add_development_dependency 'test_declarative'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end