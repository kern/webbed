require 'bundler'
Bundler.setup :default, :development, :test

require 'webbed'
require 'spec/rake/spectask'
require 'yard'

Spec::Rake::SpecTask.new do |t|
  t.libs << 'lib'
end

gemspec = eval(File.read('webbed.gemspec'))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ['webbed.gemspec'] do
  system 'gem build webbed.gemspec'
  system "gem install webbed-#{Webbed::VERSION}.gem"
end

YARD::Rake::YardocTask.new do |t|
end