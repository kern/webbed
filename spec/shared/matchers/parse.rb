require "webbed/parse_failed"

# This matcher is based on the matcher included in Parslet, but has
# modifications and simplifications to work with Webbed and Rubinius.
RSpec::Matchers.define(:parse) do |input|
  chain(:as) do |expected_output|
    @expected_output = expected_output
  end

  match do |parser|
    begin
      @actual_output = parser.parse(input)
      !defined?(@expected_output) || @expected_output == @actual_output
    rescue Webbed::ParseFailed
      false
    end
  end

  failure_message_for_should do |parser|
    if defined?(@expected_output)
      "expected output of parsing #{input.inspect} with #{parser.inspect} to equal #{@expected_output.inspect}, but was #{@actual_output.inspect}"
    else
      "expected #{parser.inspect} to be able to parse #{input.inspect}"
    end
  end

  failure_message_for_should_not do |parser|
    if defined?(@expected_output)
      "expected output of parsing #{input.inspect} with #{parser.inspect} not to equal #{@expected_output.inspect}"
    else
      "expected #{parser.inspect} to not parse #{input.inspect}, but it did"
    end
  end
end
