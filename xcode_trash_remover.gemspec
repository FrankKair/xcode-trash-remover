# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcode_trash_remover/version'

Gem::Specification.new do |spec|
  spec.name          = 'xcode_trash_remover'
  spec.version       = XcodeTrashRemover::VERSION
  spec.authors       = ['Frank Kair']
  spec.email         = ['frankkair@gmail.com']

  spec.summary       = 'Simple script to remove Xcode trash files'
  spec.description   = 'Script to remove trash files that Xcode generates'
  spec.homepage      = 'https://www.github.com/FrankKair/xcode-trash-remover'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.2'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f =~ /docs\// }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 2.4', '< 5'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 13.0'
end
