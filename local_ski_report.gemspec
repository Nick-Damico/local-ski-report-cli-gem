# lib = File.expand_path('../lib', __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative './lib/local_ski_report/version'

Gem::Specification.new do |spec|
  spec.name          = 'local_ski_report'
  spec.version       = LocalSkiReport::VERSION
  spec.date          = '2017-08-12'
  spec.authors       = ['Nick Alan DAmico']
  spec.email         = ['nickalan82@icloud.com']

  spec.summary       = 'Ski Reports from local Ski Areas'
  spec.description   = 'Find the latest ski report from your local ski area or resort.'
  spec.homepage      = 'https://github.com/Nick-Damico/local-ski-report-cli-gem'
  spec.license       = 'MIT'

  spec.executables   = ['local_ski_report']
  spec.files         = ['lib/local_ski_report.rb', 'lib/local_ski_report/cli.rb', 'lib/local_ski_report/report.rb', 'lib/local_ski_report/resort.rb', 'lib/local_ski_report/scraper.rb', 'config/environment.rb']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_runtime_dependency 'nokogiri',
                              ['>= 1.8.1']
  spec.add_runtime_dependency 'terminal-table', ['>= 1.8.0']
end
