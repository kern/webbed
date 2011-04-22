require 'bundler/setup'
require 'minitest/autorun'
require 'turn'
require 'mocha'
require 'webbed'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }