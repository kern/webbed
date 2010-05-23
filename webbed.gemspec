require File.expand_path('../lib/webbed/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'webbed'
  s.version = Webbed::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = 'Library for manipulating HTTP messages'
  s.description = 'Ruby library that allows you to take full advantage of all the data HTTP messages can offer.'
  s.required_ruby_version = '>= 1.8.6'
  
  s.author = 'Alexander Kern'
  s.email = 'alex@kernul.com'
  s.homepage = 'http://github.com/CapnKernul/webbed'
  
  s.rubyforge_project = 'webbed'
  
  s.files = Dir['lib/**/*', 'LICENSE', '*.md']
  s.require_path = 'lib'
  
  require 'bundler'
  s.add_bundler_dependencies
  s.dependencies.delete_if do |dep|
    dep.name == 'webbed'
  end
end