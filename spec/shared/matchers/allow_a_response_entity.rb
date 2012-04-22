RSpec::Matchers.define :allow_a_response_entity do
  match do |actual|
    actual.allows_response_entity?
  end
end
