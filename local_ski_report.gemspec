# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'local_ski_report/version'

Gem::Specification.new do |spec|
  spec.name          = "local_ski_report"
  spec.version       = '0.1.0'
  spec.date          = '2017-08-12'
  spec.authors       = ["Nick Alan DAmico"]
  spec.email         = ["nickalan82@icloud.com"]

  spec.summary       = "Ski Reports from local Ski Areas"
  spec.description   = "Gives latest ski reports from a local ski area or resort"
  spec.homepage      = "https://github.com/Nick-Damico/local-ski-report-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # spec.files         = `git ls-files -z`.split("\x0").reject do |f|
  #   f.match(%r{^(test|spec|features)/})
  # end
  spec.bindir        = "exe"
  spec.executables   = ["local-ski-report"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_dependency             "nokogiri"
  # spec.add_dependency             "open-uri"
  spec.add_dependency             "terminal-table", "~> 1.8.0"
end
