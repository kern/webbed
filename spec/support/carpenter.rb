require "carpenter"

Carpenter::BuilderLoader.load_all
RSpec.configure do |config|
  config.include Carpenter::BuildDSL
end
