require 'foot_stats'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into(:fakeweb)
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros
end

FootStats::Setup.setup do |config|
  config.base_url = 'http://footstats.com.br/modyo.asmx'
end