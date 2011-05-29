require 'bundler/setup'
require 'minitest/autorun'
require 'journo'
require 'mocha'
require 'test_declarative'
require 'webbed'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

module WebbedTest
  class TestCase < MiniTest::Unit::TestCase
    include Assertions
  end
end

MiniTest::Unit.runner = Journo::SuiteRunner.new
MiniTest::Unit.runner.reporters << Journo::Reporters::ProgressReporter.new