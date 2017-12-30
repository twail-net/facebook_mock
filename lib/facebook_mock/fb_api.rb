# frozen_string_literal: true

require 'sinatra/base'

require 'facebook_mock/database'

module FacebookMock
  class FbApi < Sinatra::Base
    FBV = 'v2.10'

    @db = Database.new
    class << self; attr_reader :db end

    def self.run_in_background!
      Thread.new { run! }
    end

    get "/#{FBV}/:id" do
      # TODO: the id can also be an alias
      FbApi.db.find(params['id'])
    end

    error ApiError do |e|
      e.to_json
    end
  end
end
