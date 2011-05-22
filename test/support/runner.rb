require 'minitest/unit'
require 'ansi'
require 'progressbar'

# Code has been borrowed and modified from MiniTest, written by Ryan Davis of
# Seattle.rb. MiniTest is licensed under the MIT License, and can be found on
# GitHub at https://github.com/seattlerb/minitest.
# 
# This code is also heavily based upon these gists as well:
# * https://gist.github.com/356945
# * https://gist.github.com/960669
# 
# TODO: Add documentation to everything.

module Perfection
  class Reporter
    def runner
      Perfection::Runner.runner
    end
    
    def print(*args)
      runner.output.print(*args)
    end
    
    def puts(*args)
      runner.output.puts(*args)
    end
    
    def before_suites(suites); end
    def after_suites(suites); end
    def before_suite(suite); end
    def after_suite(suite); end
    def before_test(suite, test); end
    def pass(suite, test); end
    def skip(suite, test, e); end
    def failure(suite, test, e); end
    def error(suite, test, e); end
  end
  
  # Takes a signficant amount of code from Jef Kreefmeijer's Fuubar. Fuubar is
  # licensed under the MIT License and can be found at:
  # https://github.com/jeffkreeftmeijer/fuubar.
  class ProgressReporter < Reporter
    include ANSI::Code
    
    INFO_PADDING = 2
    
    def before_suites(suites)
      puts 'Started'
      puts
      
      @color = GREEN
      @finished_count = 0
      @progress = ProgressBar.new("0/#{runner.test_count}", runner.test_count, runner.output)
      @progress.bar_mark = '='
    end
    
    def increment
      with_color do
        @finished_count += 1
        @progress.instance_variable_set('@title', "#{@finished_count}/#{runner.test_count}")
        @progress.inc
      end
    end
    
    def pass(suite, test)
      increment
    end
    
    def skip(suite, test, e)
      @color = YELLOW unless @color == RED
      print(yellow { 'SKIP' })
      print_test_with_time(suite, test)
      puts
      puts
      increment
    end
    
    def failure(suite, test, e)
      @color = RED
      print(red { 'FAIL' })
      print_test_with_time(suite, test)
      puts
      print_info(e)
      puts
      increment
    end
    
    def error(suite, test, e)
      @color = RED
      print(red { 'ERROR' })
      print_test_with_time(suite, test)
      puts
      print_info(e)
      puts
      increment
    end
    
    def after_suites(suites)
      with_color { @progress.finish }
      
      total_time = Time.now - runner.start_time
      
      puts
      puts('Finished in %.5fs' % total_time)
      print('%d tests, %d assertions, ' % [runner.test_count, runner.assertion_count])
      print(red { '%d failures, %d errors, ' } % [runner.failures, runner.errors])
      print(yellow { '%d skips' } % runner.skips)
      puts
    end
    
    private
    
    def print_test_with_time(suite, test)
      total_time = Time.now - runner.test_start_time
      print(" #{suite}##{test} (%.2fs)#{clr}" % total_time)
    end
    
    def print_info(e)
      e.message.each_line { |line| puts pad(line) }
      
      trace = MiniTest.filter_backtrace(e.backtrace)
      trace.each { |line| puts pad(line) }
    end
    
    def pad(str)
      ' ' * INFO_PADDING + str
    end
    
    def with_color
      print @color
      yield
      print CLEAR
    end
  end
  
  class SpecReporter < Reporter
    include ANSI::Code
    
    TEST_PADDING = 2
    INFO_PADDING = 8
    MARK_SIZE    = 5
    
    def before_suites(suites)
      puts 'Started'
      puts
    end
    
    def after_suites(suites)
      total_time = Time.now - runner.start_time
      
      puts('Finished in %.5fs' % total_time)
      print('%d tests, %d assertions, ' % [runner.test_count, runner.assertion_count])
      print(red { '%d failures, %d errors, ' } % [runner.failures, runner.errors])
      print(yellow { '%d skips' } % runner.skips)
      puts
    end
    
    def before_suite(suite)
      puts suite
    end
    
    def after_suite(suite)
      puts
    end
    
    def pass(suite, test)
      print(green { pad_mark('PASS') })
      print_test_with_time(test)
      puts
    end
    
    def skip(suite, test, e)
      print(yellow { pad_mark('SKIP') })
      print_test_with_time(test)
      puts
    end
    
    def failure(suite, test, e)
      print(red { pad_mark('FAIL') })
      print_test_with_time(test)
      puts
      print_info(e)
      puts
    end
    
    def error(suite, test, e)
      print(red { pad_mark('ERROR') })
      print_test_with_time(test)
      puts
      print_info(e)
      puts
    end
    
    private
    
    def print_test_with_time(test)
      total_time = Time.now - runner.test_start_time
      print(" #{test} (%.2fs)" % total_time)
    end
    
    def print_info(e)
      e.message.each_line { |line| puts pad(line, INFO_PADDING) }
      
      trace = MiniTest.filter_backtrace(e.backtrace)
      trace.each { |line| puts pad(line, INFO_PADDING) }
    end
    
    def pad(str, size)
      ' ' * size + str
    end
    
    def pad_mark(str)
      pad("%#{MARK_SIZE}s" % str, TEST_PADDING)
    end
  end
  
  class Runner < MiniTest::Unit
    class << self
      attr_writer :reporter
      
      def reporter
        @reporter ||= ProgressReporter.new
      end
    end
    
    attr_accessor :suite_start_time, :test_start_time
    
    def reporter
      self.class.reporter
    end
    
    def puke(suite, method, e)
      case e
      when MiniTest::Skip then
        @skips += 1
        [:skip, e]
      when MiniTest::Assertion then
        @failures += 1
        [:failure, e]
      else
        @errors += 1
        [:error, e]
      end
    end
    
    def _run_anything(type)
      suites = TestCase.send("#{type}_suites")
      return if suites.empty?
      
      @test_count = suites.inject(0) { |acc, suite| acc + suite.send("#{type}_methods").length }
      @assertion_count = 0
      
      @start_time = Time.now
      reporter.before_suites(suites)
      fix_sync { _run_suites(suites, type) }
      reporter.after_suites(suites)
    end
    
    def _run_suites(suites, type)
      suites.each { |suite| _run_suite(suite, type) }
    end
    
    def _run_suite(suite, type)
      run_suite_header(suite, type)
      
      filter = options[:filter] || '/./'
      filter = Regexp.new($1) if filter =~ /\/(.*)\//
      
      tests = suite.send("#{type}_methods").grep(filter)
      
      unless tests.empty?
        @suite_start_time = Time.now
        reporter.before_suite(suite)
        _run_tests(suite, tests)
        reporter.after_suite(suite)
      end
    end
    
    private
    
    def run_suite_header(suite, type)
      header_method = "#{type}_suite_header"
      send(header_method, suite) if respond_to?(header_method)
    end
    
    def _run_tests(suite, tests)
      suite.startup if suite.respond_to?(:startup)
      tests.each { |test| _run_test(suite, test) }
    ensure
      suite.shutdown if suite.respond_to?(:shutdown)
    end
    
    def _run_test(suite, test)
      @test_start_time = Time.now
      reporter.before_test(suite, test)
      
      suite_instance = suite.new(test)
      suite_instance._assertions = 0
      
      result = fix_result(suite_instance.run(self))
      @assertion_count += suite_instance._assertions
      
      case result[0]
      when :pass then reporter.pass(suite, test)
      when :skip then reporter.skip(suite, test, result[1])
      when :failure then reporter.failure(suite, test, result[1])
      else reporter.error(suite, test, result[1])
      end
    end
    
    def fix_result(result)
      result == '.' ? [:pass, nil] : result
    end
    
    def fix_sync
      sync = output.respond_to?(:'sync=') # stupid emacs
      old_sync, output.sync = output.sync, true if sync
      yield
      output.sync = old_sync if sync
    end
  end
end

Perfection::Runner.runner = Perfection::Runner.new
Perfection::Runner.reporter = Perfection::ProgressReporter.new