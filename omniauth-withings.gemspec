# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/omniauth-withings/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-withings"
  spec.version       = OmniAuth::Withings::VERSION
  spec.authors       = ["flada-auxv"]
  spec.email         = ["aseknock@gmail.com"]

  spec.summary       = "OmniAuth strategy for Withings"
  spec.description   = "OmniAuth strategy for Withings"
  spec.homepage      = "https://github.com/flada-auxv/omniauth-withings"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "omniauth-oauth"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
end
