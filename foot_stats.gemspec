# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foot_stats/version'

Gem::Specification.new do |gem|
  gem.name          = "foot_stats"
  gem.version       = FootStats::VERSION
  gem.authors       = ["Tomas D'Stefano"]
  gem.email         = ["tomas_stefano@successoft.com"]
  gem.description   = %q{FootStats API Client in Ruby.}
  gem.summary       = %q{FootStats API Client.}
  gem.homepage      = "https://github.com/tomas-stefano/foot_stats"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activesupport'
  gem.add_dependency 'rest-client'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'fakeweb'
end
