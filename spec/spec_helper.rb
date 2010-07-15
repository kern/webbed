require 'bundler'
Bundler.setup :default, :test

require 'spec'
require 'bourne'

require 'webbed'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

Spec::Runner.configure do |config|
  config.mock_with :mocha
end