require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('continued_fractions', '1.3.1') do |config|
  config.summary                  = 'Generate continued fractions'
  config.description              = 'Class for working with continued fractions'
  
  config.ruby_version              = ">=2.2.2"
  config.licenses                  = 'MIT'
  
  config.author                   = 'Jose Hales-Garcia'
  config.email                    = 'jolohaga@me.com'
  config.url                      = 'http://github.com/jolohaga/continued_fractions'
  
  config.ignore_pattern           = ["tmp/*",".hg/*", ".pkg/*", ".git/*"]

  config.development_dependencies = ['rspec ~>3.2.0','echoe ~>4.6.6']
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each{|ext| load ext}