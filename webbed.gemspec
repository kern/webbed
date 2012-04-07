require File.expand_path("../lib/webbed/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexander Kern"]
  gem.email         = ["alex@kernul.com"]
  gem.description   = %q{Webbed implements all of the application-level logic of HTTP. It provides abstractions for all of the entities described in the specification and an intuitive interface for the algorithms defined in RFC 2616, including Content Negotiation and Cache Control.}
  gem.summary       = %q{Take control of HTTP.}
  gem.homepage      = "https://github.com/CapnKernul/webbed"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "webbed"
  gem.require_paths = ["lib"]
  gem.version       = Webbed::VERSION

  gem.add_dependency "addressable"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "bundler"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "yard"
  gem.add_development_dependency "redcarpet"
end
