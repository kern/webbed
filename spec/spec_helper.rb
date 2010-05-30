require 'bundler'
Bundler.setup :default, :test

require 'spec'

require 'webbed'
require 'factory_girl'
require 'support/helpers'
require 'support/matchers'

Spec::Runner.configure do |config|
  config.include Webbed::Spec::Matchers
end