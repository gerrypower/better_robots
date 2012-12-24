# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'better_robots/version'

Gem::Specification.new do |gem|
  gem.name          = "better_robots"
  gem.version       = BetterRobots::VERSION
  gem.authors       = ["Gerry Power"]
  gem.email         = ["gerry@thepowerhouse.com"]
  gem.description   = "Better SEO with robots.txt"
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/gerrypower/better_robots"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
