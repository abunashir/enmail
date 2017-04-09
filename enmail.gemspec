# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "enmail/version"

Gem::Specification.new do |spec|
  spec.name          = "enmail"
  spec.version       = EnMail::VERSION
  spec.authors       = ["Ronald Tse"]
  spec.email         = ["ronald.tse@ribose.com"]

  spec.summary       = %q{Encrypted Email in Ruby}
  spec.description   = %q{Encrypted Email in Ruby}
  spec.homepage      = "https://github.com/riboseinc/enmail"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "mail", "~> 2.6.4"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~>0.10.3"
end