# frozen_string_literal: true

require "facebook_mock/version"
require "facebook_mock/fb_api"

module FacebookMock
  # Your code goes here...

  # setter

  # insights is json with the insights values
  def set_insights(ad_acc_id, object_id, insights)
    ad_acc = FbApi.db.find(ad_acc_id)
    if ad_acc['insights'].nil?
      ad_acc['insights'] = { object_id: insights }
    else
      ad_acc['insights'][object_id] = insights
    end
    ad_acc.save!
  end

  # assigned users is a json of the assigned users with their respective 
  # ids, permitted_roles and access_status
  def set_assigned_users(page_id, assigned_users)
    page = FbApi.db.find(page_id)
    page['assigned_users'] = assigned_users
    page.save!
  end

  # pages is a list of page_ids
  def set_pages(business_acc_id, pages)
    business_acc = FbApi.db.find(business_acc_id)
    business_acc['pages'] = pages
    business_acc.save!
  end

  # ads is a list of ad ids
  def set_ads(ad_set_id, ads)
    ad_set = FbApi.db.find(ad_set_id)
    ad_set['ads'] = ads
    ad_set.save!
  end

  # getter
  def get_insights(ad_acc_id, object_id)
    ad_acc = FbApi.db.find(ad_acc_id)
    return nil if ad_acc['insights'].nil?
    ad_acc['insights'][object_id]
  end

  def get_assigned_users(page_id)
    FbApi.db.find(page_id)['assigned_users']
  end

  def get_pages(business_acc_id)
    business_acc = FbApi.db.find(business_acc_id)
    pages = business_acc['pages']
    ret = []
    pages.each do |page_id|
      ret << FbApi.db.find(page_id)
    end
    ret
  end

  def get_ads(ad_set_id)
    ad_set = FbApi.db.find(ad_set_id)
    ads = ad_set['ads']
    ret = []
    ads.each do |ad_id|
      ret << FbApi.db.find(ad_id)
    end
    ret
  end
end
