require 'bundler'
Bundler.setup :default, :test

require 'spec'
require 'webbed'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }