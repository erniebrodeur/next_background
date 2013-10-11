# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'next_background/version'

Gem::Specification.new do |spec|
  spec.name          = "next_background"
  spec.version       = NextBackground::VERSION
  spec.authors       = ["Ernie Brodeur"]
  spec.email         = ["ebrodeur@ujami.net"]
  spec.description   = "A description."
  spec.summary       = "A slightly longer description."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
