# frozen_string_literal: true

require 'facebook_mock/api_error'
module FacebookMock
  class Database
    def initialize
      @db = {}
      @aliases = {}
      @id = 1
    end

    def find(id)
      did = dealias(id)
      raise ApiError.not_found did unless db.key? did
      db[did]
    end

    def create_fb_page(aliasid, name: nil)
      id = new_alias(aliasid)
      db[id] = {
        id: id,
        name: name || aliasid,
      }
    end

    def create_business_acc(aliasid, name: nil)
      id = new_alias(aliasid)
      db[id] = {
        id: id,
        name: 'act_' + (name || aliasid),
      }
    end

    def create_ad_acc(aliasid, name: nil)
      id = new_alias(aliasid)
      db[id] = {
        id: id,
        name: name || aliasid,
      }
    end

    def create_ad(aliasid, name: nil)
      id = new_alias(aliasid)
      db[id] = {
        id: id,
        name: name || aliasid,
      }
    end

    def create_ad_set(aliasid, name: nil)
      id = new_alias(aliasid)
      db[id] = {
        id: id,
        name: name || aliasid,
      }
    end

    def create_ad_creative(aliasid, name: nil)
      id = new_alias(aliasid)
      db[id] = {
        id: id,
        name: name || aliasid,
      }
    end

    def create_ad_campaign(aliasid, name: nil)
      id = new_alias(aliasid)
      db[id] = {
        id: id,
        name: name || aliasid,
      }
    end

    def clear
      @aliases = {}
      @db = {}
    end

    private

    def dealias(id)
      return id if id.match?(/^\d+$/)
      raise ApiError.alias_not_found(id) unless @aliases.key? id

      @aliases[id]
    end

    def new_alias(aliasid)
      raise 'Alias must not be empty' if aliasid.nil? || aliasid == ""
      # raise 'Alias must not be numeric' if aliasid.match?(/^\d+$/) # TODO: why is this checked, because most aliases are numeric
      raise 'Alias already exists' unless @aliases[aliasid].nil?

      @aliases[aliasid] = new_id
    end

    def new_id
      # TOOD: this is not thread-safe
      (@id += 1).to_s
    end

    attr_reader :db
  end
end
