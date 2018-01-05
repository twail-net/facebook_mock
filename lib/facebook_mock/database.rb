# frozen_string_literal: true

require 'facebook_mock/api_error'
module FacebookMock
  class Database
    def initialize
      @db = {}
      @aliases = {}
      @classes = {}
      @id = 1
    end

    def find(id)
      did = dealias(id)
      raise ApiError.not_found did unless db.key? did
      db[did]
    end

    def create_fb_page(aliasid, name: nil)
      id = new_alias(aliasid)
      @classes[id] = "fb_page"
      db[id] = {
        id: id,
        name: name || aliasid,
      }
    end

    def create_business_acc(name: nil)
      id = 'act_' + new_id
      @classes[id] = "business_account"
      db[id] = {
        id: id,
        name: name,
      }
    end

    def create_ad_acc(name: nil)
      id = new_id
      @classes[id] = "ad_account"
      db[id] = {
        id: id,
        name: name,
      }
    end

    def create_ad(name: nil)
      id = new_id
      @classes[id] = "ad"
      db[id] = {
        id: id,
        name: name,
      }
    end

    def create_ad_set(name: nil)
      id = new_id
      @classes[id] = "ad_set"
      db[id] = {
        id: id,
        name: name,
      }
    end

    def create_ad_creative(name: nil)
      id = new_id
      @classes[id] = "ad_creative"
      db[id] = {
        id: id,
        name: name,
      }
    end

    def create_campaign(name: nil)
      id = new_id
      @classes[id] = "campaign"
      db[id] = {
        id: id,
        name: name,
      }
    end

    # setter

    # insights is json with the insights values
    def set_insights(ad_acc_id, object_id, insights)
      raise ApiError.edge_not_existing("insights") unless @classes[ad_acc_id] == "ad_account"
      ad_acc = FbApi.db.find(ad_acc_id)
      if ad_acc[:insights].nil?
        ad_acc[:insights] = { object_id => insights }
      else
        ad_acc[:insights][object_id] = insights
      end
    end

    # assigned users is a list of json of the assigned users with their respective
    # ids, permitted_roles and access_status
    def set_assigned_users(page_id, assigned_users)
      raise ApiError.edge_not_existing("assigned_users") unless @classes[page_id] == "fb_page"
      page = FbApi.db.find(page_id)
      page[:assigned_users] = assigned_users
    end

    # ad creatives is a list of json of the adcreatives users with their respective object_story_spec
    def set_adcreatives(ad_id, adcreatives)
      raise ApiError.edge_not_existing("adcreatives") unless @classes[ad_id] == "ad"
      ad = FbApi.db.find(ad_id)
      ad[:adcreatives] = adcreatives
    end

    # pages is a list of page_ids
    def set_pages(business_acc_id, pages)
      raise ApiError.edge_not_existing("pages") unless @classes[business_acc_id] == "business_account"
      business_acc = FbApi.db.find(business_acc_id)
      business_acc[:pages] = pages
    end

    # ads is a list of ad ids
    def set_ads(ad_set_id, ads)
      raise ApiError.edge_not_existing("ads") unless @classes[ad_set_id] == "ad_set"
      ad_set = FbApi.db.find(ad_set_id)
      ad_set[:ads] = ads
    end

    def clear
      @aliases = {}
      @db = {}
      @classes = {}
    end

    # getter
    def get_insights(ad_acc_id, object_ids)
      raise ApiError.edge_not_existing("insights") unless @classes[ad_acc_id] == "ad_account"
      ad_acc = FbApi.db.find(ad_acc_id)
      return nil if ad_acc[:insights].nil?
      { id: ad_acc_id, insights: object_ids.tr('[]', '').split(",").map { |id| ad_acc[:insights][id] } }
    end

    def get_assigned_users(page_id, fields)
      raise ApiError.edge_not_existing("assigned_users") unless @classes[page_id] == "fb_page"
      return { id: page_id, data: FbApi.db.find(page_id)[:assigned_users] } if fields.nil?
      users = []
      FbApi.db.find(page_id)[:assigned_users].each do |user|
        current = {}
        current["permitted_roles"] = user["permitted_roles"] if fields.contains?("permitted_roles")
        current["access_status"] = user["access_status"] if fields.contains?("access_status")
        users << current
      end
      { id: page_id, data: users }
    end

    def get_pages(business_acc_id)
      raise ApiError.edge_not_existing("pages") unless @classes[business_acc_id] == "business_account"
      business_acc = FbApi.db.find(business_acc_id)
      { id: business_acc_id, data: business_acc[:pages] }
    end

    def get_ads(ad_set_id, fields)
      raise ApiError.edge_not_existing("ads") unless @classes[ad_set_id] == "ad_set"
      ad_set = FbApi.db.find(ad_set_id)
      return { id: ad_set_id, data: ad_set[:ads] } if fields.nil?
      ads = []
      ad_set[:ads].each do |ad_id|
        current = {}
        ad = FbApi.db.find(ad_id)
        current["effective_status"] = ad["status"] if fields.contains?("effective_status")
        current["previews"] = { "data" => [{ "body" => ad["preview"] }] } if fields.contains?("previews")
        ads << current
      end
      { id: ad_set_id, data: ads }
    end

    def get_adcreatives(ad_id, fields)
      raise ApiError.edge_not_existing("adcreatives") unless @classes[ad_id] == "ad"
      ad = FbApi.db.find(ad_id)
      return { id: ad_id, data: ad[:adcreatives] } if fields.nil?
      adcreatives = []
      ad[:adcreatives].each do |adcreative|
        current = {}
        current["object_story_spec"] = adcreative["object_story_spec"] if fields.contains?("object_story_spec")
        adcreatives << current
      end
      { id: ad_set_id, data: adcreatives }
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
