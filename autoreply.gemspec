# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autoreply/version'

Gem::Specification.new do |spec|
  spec.name          = "autoreply"
  spec.version       = Autoreply::VERSION
  spec.authors       = ["Sergey Kishenin", "Dmitry Naumov"]
  spec.email         = ["sergey.kishenin@gmail.com", "naumovmail@gmail.com"]

  spec.summary       = %q{Detect if email is autoresponder or "out-of-office" email}
  spec.description   = %q{Detect if email is autoresponder or "out-of-office" email}
  spec.homepage      = "https://github.com/edufii/autoreply"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "mail"
end
