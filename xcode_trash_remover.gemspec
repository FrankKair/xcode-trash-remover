
lib = File.expand_path('../lib', __FILE__)
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

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f =~ /docs\// }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'filesize', '~> 0.1.1'
end
