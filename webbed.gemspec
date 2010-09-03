# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
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
  
  s.required_rubygems_version = '~> 1.3.6'
  s.rubyforge_project         = 'webbed'
  
  s.add_dependency 'addressable', '~> 2.2'
  
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rspec', '2.0.0.beta.20'
  s.add_development_dependency 'watchr', '~> 0.6'
  s.add_development_dependency 'derickbailey-notamock', '~> 0.0.1'
  
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map {|f| f[%r{^bin/(.*)}, 1]}.compact
  s.require_path = 'lib'
end