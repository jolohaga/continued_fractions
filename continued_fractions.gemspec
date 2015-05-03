# -*- encoding: utf-8 -*-
# stub: continued_fractions 1.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "continued_fractions"
  s.version = "1.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jose Hales-Garcia"]
  s.date = "2015-05-03"
  s.description = "Class for working with continued fractions."
  s.email = "jolohaga@me.com"
  s.extra_rdoc_files = ["CHANGELOG", "README.txt", "lib/continued_fractions.rb"]
  s.files = ["CHANGELOG", "History.txt", "Manifest", "README.txt", "Rakefile", "continued_fractions.gemspec", "lib/continued_fractions.rb", "spec/continued_fractions/continued_fraction_spec.rb", "spec/spec_helper.rb"]
  s.homepage = "http://github.com/jolohaga/continued_fractions"
  s.rdoc_options = ["--line-numbers", "--title", "Continued_fractions", "--main", "README.txt"]
  s.rubyforge_project = "continued_fractions"
  s.rubygems_version = "2.4.5"
  s.summary = "Generate continued fractions."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_development_dependency(%q<echoe>, [">= 4.3"])
    else
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_dependency(%q<echoe>, [">= 4.3"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
    s.add_dependency(%q<echoe>, [">= 4.3"])
  end
end
