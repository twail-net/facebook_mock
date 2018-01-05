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

    get "/#{FBV}/:id/:edge" do
      if params['edge'] == 'ads'
        FbApi.db.get_ads(params['id']).to_json
      elsif params['edge'] == 'pages'
        FbApi.db.get_pages(params['id']).to_json
      elsif params['edge'] == 'assigned_uses'
        FbApi.db.get_assigned_users(params['id']).to_json
      elsif params['edge'] == 'insights'
        FbApi.db.get_insights(params['id'], params["ids"]).to_json
      end
    end

    get "/#{FBV}/:id" do
      # TODO: the id can also be an alias, e.g. search
      FbApi.db.find(params['id']).to_json
    end

    get "/#{FBV}/search" do
      # TODO
    end

    error ApiError, &:to_json
  end
end
