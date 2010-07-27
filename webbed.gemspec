require File.expand_path('../lib/webbed/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'webbed'
  s.version = Webbed::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = 'Consistent library of manipulating HTTP messages'
  s.description = 'Consistent library of manipulating HTTP messages'
  s.required_ruby_version = '>= 1.8.7'
  
  s.author = 'Alexander Kern'
  s.email = 'alex@kernul.com'
  s.homepage = 'http://github.com/CapnKernul/webbed'
  
  s.rubyforge_project = 'webbed'
  
  s.files = Dir['lib/**/*', 'LICENSE', '*.md', 'Rakefile', 'Gemfile']
  s.require_path = 'lib'
  
  require 'bundler'
  s.add_bundler_dependencies
  s.dependencies.delete_if do |dep|
    dep.name == 'webbed'
  end
end