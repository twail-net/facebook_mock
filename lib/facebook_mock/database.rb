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

    def create_business_acc(name: nil)
      id = 'act_' + new_id
      db[id] = {
        id: id,
        name: name,
      }
    end

    def create_ad_acc(name: nil)
      id = new_id
      db[id] = {
        id: id,
        name: name,
      }
    end

    def create_ad(name: nil)
      id = new_id
      db[id] = {
        id: id,
        name: name,
      }
    end

    def create_ad_set(name: nil)
      id = new_id
      db[id] = {
        id: id,
        name: name,
      }
    end

    def create_ad_creative(name: nil)
      id = new_id
      db[id] = {
        id: id,
        name: name,
      }
    end

    def create_campaign(name: nil)
      id = new_id
      db[id] = {
        id: id,
        name: name,
      }
    end

    # setter

    # insights is json with the insights values
    def set_insights(ad_acc_id, object_id, insights)
      ad_acc = FbApi.db.find(ad_acc_id)
      if ad_acc[:insights].nil?
        ad_acc[:insights] = { object_id => insights }
      else
        ad_acc[:insights][object_id] = insights
      end
    end

    # assigned users is a json of the assigned users with their respective
    # ids, permitted_roles and access_status
    def set_assigned_users(page_id, assigned_users)
      page = FbApi.db.find(page_id)
      page[:assigned_users] = assigned_users
    end

    # pages is a list of page_ids
    def set_pages(business_acc_id, pages)
      business_acc = FbApi.db.find(business_acc_id)
      business_acc[:pages] = pages
    end

    # ads is a list of ad ids
    def set_ads(ad_set_id, ads)
      ad_set = FbApi.db.find(ad_set_id)
      ad_set[:ads] = ads
    end

    def clear
      @aliases = {}
      @db = {}
    end

    # getter
    def get_insights(ad_acc_id, object_ids)
      ad_acc = FbApi.db.find(ad_acc_id)
      return nil if ad_acc[:insights].nil?
      { id: ad_acc_id, insights: object_ids.tr('[]', '').split(",").map { |id| ad_acc[:insights][id] } }
    end

    def get_assigned_users(page_id)
      FbApi.db.find(page_id)[:assigned_users]
    end

    def get_pages(business_acc_id)
      business_acc = FbApi.db.find(business_acc_id)
      pages = business_acc[:pages]
      ret = []
      pages.each do |page_id|
        ret << FbApi.db.find(page_id)
      end
      ret
    end

    def get_ads(ad_set_id)
      ad_set = FbApi.db.find(ad_set_id)
      ads = ad_set[:ads]
      ret = []
      ads.each do |ad_id|
        ret << FbApi.db.find(ad_id)
      end
      ret
    end

    private

    def dealias(id)
      return id if id.match?(/^\d+$/)
      return id if id.match?(/^(act_*?)?(\d+$)/)
      raise ApiError.alias_not_found(id) unless @aliases.key? id

      @aliases[id]
    end

    def new_alias(aliasid)
      raise 'Alias must not be empty' if aliasid.nil? || aliasid == ""
      raise 'Alias must not be numeric' if aliasid.match?(/^\d+$/)
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
