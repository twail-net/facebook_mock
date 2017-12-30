# frozen_string_literal: true

require 'sinatra/base'

require 'facebook_mock/database'

module FacebookMock
  class FbApi < Sinatra::Base
    FBV = 'v2.10'

    @db = Database.new
    class << self; attr_reader :db end

    get "/#{FBV}/:id" do
      # TODO: the id can also be an alias
      @db.find(params['id'])
    end
  end
end
