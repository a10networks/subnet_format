# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'subnet_format/version'

Gem::Specification.new do |spec|
  spec.name          = "subnet_format"
  spec.version       = SubnetFormat::VERSION
  spec.authors       = ["John Otander"]
  spec.email         = ["johnotander@gmail.com"]
  spec.summary       = %q{Validates a subnet}
  spec.description   = %q{Validates a subnet given a range, subnet mask, gateway IP, and network address.}
  spec.homepage      = "https://github.com/a10networks/subnet_format"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"

  spec.add_dependency "activemodel"
end
