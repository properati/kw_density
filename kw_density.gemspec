# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kw_density/version'

Gem::Specification.new do |spec|
  spec.name          = "kw_density"
  spec.version       = KwDensity::VERSION
  spec.authors       = ["martin sarsale"]
  spec.email         = ["martin@properati.com"]
  spec.description   = %q{Esta gema cuenta palabras.}
  spec.summary       = %q{Y te da el top(n), etc}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "i18n"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
