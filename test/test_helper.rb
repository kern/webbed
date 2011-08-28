require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/reporters'
require 'mocha'
require 'test_declarative'
require 'webbed'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

module WebbedTest
  class TestCase < MiniTest::Unit::TestCase
    include Assertions
  end
end

MiniTest::Unit.runner = MiniTest::SuiteRunner.new
if ENV['TM_PID']
  MiniTest::Unit.runner.reporters << MiniTest::Reporters::RubyMateReporter.new
else
  MiniTest::Unit.runner.reporters << MiniTest::Reporters::ProgressReporter.new
end