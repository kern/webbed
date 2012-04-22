RSpec::Matchers.define :allow_a_request_entity do
  match do |actual|
    actual.allows_request_entity?
  end
end
