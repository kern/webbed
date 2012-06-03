RSpec::Matchers.define :allow_a_response_body do
  match do |actual|
    actual.allows_response_body?
  end
end
