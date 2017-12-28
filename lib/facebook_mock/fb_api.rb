# frozen_string_literal: true

require 'sinatra/base'

require 'lib/database'

module FacebookMock
  class FbApi < Sinatra::Base
    FBV = 'v2.10'
    DB = Database.new

    get "/#{FBV}/:id" do
      # TODO: the id can also be an alias
      DB.find(params['id'])
    end
  end
end
