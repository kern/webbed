RSpec::Matchers.define :allow_entity do |expected|
  match do |actual|
    actual.send("allows_#{expected}_entity?")
  end

  failure_message_for_should do |actual|
    "expected that #{actual} would allow #{expected} entities"
  end

  failure_message_for_should_not do |actual|
    "expected that #{actual} would not allow #{expected} entities"
  end

  description do
    "allow #{expected} entities"
  end
end
