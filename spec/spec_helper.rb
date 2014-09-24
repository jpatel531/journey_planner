require 'journey_planner'
require 'webmock'
require 'vcr'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start



VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/fixtures/tfl_jp_casettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
  # config.extend VCR::RSpec::Macros

end
