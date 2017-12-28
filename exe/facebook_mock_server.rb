#!/usr/bin/env ruby
# frozen_string_literal: true

require 'facebook_mock'
require 'net/http'

# Thread.new do
  FacebookMock::FbApi.run!
# end

# sleep 1

# uri = URI('http://localhost:4567/v2.10/1234')
# puts Net::HTTP.get(uri) # => String

# FbApi.stop!
