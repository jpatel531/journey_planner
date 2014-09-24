ENV['CODECLIMATE_REPO_TOKEN'] = 'c6f3050691513fe190dee1b60b55e62d9883f19b9fc50658cc95f359a1e93f38'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'journey_planner'
require 'webmock'
require 'vcr'


VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/fixtures/tfl_jp_casettes'
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
end

RSpec.configure do |config|
  # config.extend VCR::RSpec::Macros

end
