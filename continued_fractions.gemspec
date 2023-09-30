# -*- encoding: utf-8 -*-
require 'date'

Gem::Specification.new do |spec|
  spec.name = "continued_fractions"
  spec.version = "1.8.6"
  spec.summary = "Generate continued fractions"
  spec.description = "Class for working with continued fractions"
  spec.authors = ["Jose Hales-Garcia"]
  spec.email = "jose@halesgarcia.com"
  spec.homepage = "https://jolohaga.github.io/continued_fractions"
  spec.licenses = ["MIT"]
  spec.date = Date.today.to_s

  spec.files = Dir.glob("lib/**/*") + %w{LICENSE README.md}
  spec.require_paths = ["lib"]

  spec.required_rubygems_version = Gem::Requirement.new(">= 1.2") if spec.respond_to? :required_rubygems_version=
  spec.extra_rdoc_files = ["LICENSE", "README.md", "lib/continued_fractions.rb"]
  spec.rdoc_options = ["--line-numbers", "--title", "continued_fractions", "--main", "README.md"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.2.2")
  spec.rubyforge_project = "continued_fractions"
  spec.rubygems_version = "3.0.3"
  spec.add_development_dependency("rspec", ["~> 3.2"])
  spec.add_development_dependency("byebug", ["~> 11.1"])
  spec.metadata = {
    "source_code_uri" => "https://github.com/jolohaga/continued_fractions"
  }
end
