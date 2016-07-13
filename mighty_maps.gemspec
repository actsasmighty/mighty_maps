# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mighty_maps/version"

Gem::Specification.new do |spec|
  spec.name          = "mighty_maps"
  spec.version       = MightyMaps::VERSION
  spec.authors       = ["Michael Sievers"]

  spec.summary       = %q{A gem to help you build seat maps programatically using a simple DSL.}
  spec.homepage      = "https://github.com/actsasmighty/mighty_maps"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "virtus"
end
