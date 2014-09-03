# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tfl_jp/version'

Gem::Specification.new do |spec|
  spec.name          = "journey_planner"
  spec.version       = TFLJourneyPlanner::VERSION
  spec.authors       = ["jpatel531"]
  spec.email         = ["jamie@notespublication.com"]
  spec.summary       = %q{An unofficial wrapper for the TFL Journey Planner API}
  spec.description   = %q{An unofficial wrapper for the TFL Journey Planner API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir.glob("lib/**/*")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "json"
  # spec.add_runtime_dependency "ostruct"
  spec.add_runtime_dependency "recursive-open-struct"
  spec.add_runtime_dependency "activesupport"
end
