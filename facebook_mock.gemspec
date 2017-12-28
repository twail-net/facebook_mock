
# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "facebook_mock/version"

Gem::Specification.new do |spec|
  spec.name          = "facebook_mock"
  spec.version       = FacebookMock::VERSION
  spec.authors       = ["David Poetzsch-Heffter"]
  spec.email         = ["davidpoetzsch@web.de"]

  spec.summary       = "Mocks for parts of facebook's graph, marketing, and business api"
  spec.homepage      = "https://github.com/twail-net/facebook_mock"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'sinatra', '~> 2.0'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
