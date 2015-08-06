# -*- encoding: utf-8 -*-
# stub: continued_fractions 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "continued_fractions"
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jose Hales-Garcia"]
  s.date = "2015-05-10"
  s.description = "Class for working with continued fractions"
  s.email = "jolohaga@me.com"
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.md", "lib/continued_fractions.rb"]
  s.files = ["CHANGELOG", "Gemfile", "History.txt", "LICENSE", "Manifest", "README.md", "Rakefile", "continued_fractions.gemspec", "lib/continued_fractions.rb", "spec/continued_fractions/continued_fraction_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://jolohaga.github.io/continued_fractions"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--line-numbers", "--title", "Continued_fractions", "--main", "README.md"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2")
  s.rubyforge_project = "continued_fractions"
  s.rubygems_version = "2.4.5"
  s.summary = "Generate continued fractions"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 3.2.0"])
      s.add_development_dependency(%q<echoe>, ["~> 4.6.6"])
    else
      s.add_dependency(%q<rspec>, ["~> 3.2.0"])
      s.add_dependency(%q<echoe>, ["~> 4.6.6"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 3.2.0"])
    s.add_dependency(%q<echoe>, ["~> 4.6.6"])
  end
end
