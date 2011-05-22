require 'bundler/setup'
require 'minitest/autorun'
require 'mocha'
require 'test_declarative'
require 'webbed'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

module WebbedTest
  class TestCase < MiniTest::Unit::TestCase
    include Assertions
  end
end