# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capoblo/version'

Gem::Specification.new do |spec|
  spec.name          = "capoblo"
  spec.version       = Capoblo::VERSION
  spec.authors       = ["Oguzhan ilhan"]
  spec.email         = ["ilhanoguzhan@gmail.com"]

  spec.summary       = %q{Two motor robot library.}
  spec.description   = %q{Two motor robot library for raspberry pi or others.}
  spec.homepage      = "https://github.com/ilhanoguzhan."
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/).reject{|i| i=="Gemfile.lock" }
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "arduino_firmata", "~> 0.3"
end
