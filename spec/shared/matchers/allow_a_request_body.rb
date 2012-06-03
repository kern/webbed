RSpec::Matchers.define :allow_a_request_body do
  match do |actual|
    actual.allows_request_body?
  end
end
