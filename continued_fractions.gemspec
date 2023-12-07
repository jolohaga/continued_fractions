# -*- encoding: utf-8 -*-
require 'date'

Gem::Specification.new do |spec|
  spec.name = "continued_fractions"
  spec.version = "2.0.3"
  spec.summary = "Generate continued fractions"
  spec.description = "Class for working with continued fractions"
  spec.authors = ["Jose Hales-Garcia"]
  spec.email = "jose@halesgarcia.com"
  spec.homepage = "https://jolohaga.github.io/continued_fractions"
  spec.licenses = ["MIT"]
  spec.date = Date.today.to_s

  spec.files = Dir.glob("lib/**/*") + %w{LICENSE README.md}
  spec.require_paths = ["lib"]

  spec.rubyforge_project = "continued_fractions"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.1")
  spec.required_rubygems_version = Gem::Requirement.new(">= 3.1")
  spec.rubygems_version = "3.4.22"

  spec.add_development_dependency("rspec", ["~> 3.2"])
  spec.add_development_dependency("byebug", ["~> 11.1"])
  spec.add_development_dependency "yard", ["~> 0.9"]
  spec.metadata = {
    "source_code_uri" => "https://github.com/jolohaga/continued_fractions"
  }
end
