# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require "bundler/setup"
require "facebook_mock"
require 'rack/test'
require 'byebug'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random

  Kernel.srand config.seed
end
