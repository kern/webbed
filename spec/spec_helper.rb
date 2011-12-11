require "bundler/setup"
require "rspec/autorun"
require "webbed"

Dir["spec/support/**/*.rb"].each { |f| require File.expand_path(f) }
