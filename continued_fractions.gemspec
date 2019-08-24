# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'continued_fractions/version'

Gem::Specification.new do |spec|
  spec.name = "continued_fractions"
  spec.version = ContinuedFractions::VERSION

  spec.required_rubygems_version = Gem::Requirement.new(">= 1.2") if spec.respond_to? :required_rubygems_version=
  spec.require_paths = ["lib"]
  spec.authors = ["Jose Hales-Garcia"]
  spec.date = "2016-10-26"
  spec.description = "Class for working with continued fractions"
  spec.email = "jolohaga@me.com"
  spec.extra_rdoc_files = ["LICENSE", "README.md", "lib/continued_fractions.rb"]
  spec.files = ["Gemfile", "LICENSE", "README.md", "Rakefile", "continued_fractions.gemspec", "lib/continued_fractions.rb", "lib/continued_fractions/version.rb", "spec/continued_fractions/continued_fraction_spec.rb", "spec/spec_helper.rb"]
  spec.homepage = "http://jolohaga.github.io/continued_fractions"
  spec.licenses = ["MIT"]
  spec.rdoc_options = ["--line-numbers", "--title", "continued_fractions", "--main", "README.md"]
  spec.required_ruby_version = Gem::Requirement.new(">= 2.2.2")
  spec.rubyforge_project = "continued_fractions"
  spec.rubygems_version = "2.5.1"
  spec.summary = "Generate continued fractions"

  if spec.respond_to? :specification_version then
    spec.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      spec.add_development_dependency(%q<rspec>, ["~> 3.2"])
    else
      spec.add_dependency(%q<rspec>, ["~> 3.2"])
    end
  else
    spec.add_dependency(%q<rspec>, ["~> 3.2"])
  end
end
