# frozen_string_literal: true

RSpec.describe FacebookMock::FbApi do
  def app
    FacebookMock::FbApi # this defines the active application for this test
  end

  def json_body
    JSON.parse(last_response.body)
  end

  after { described_class.db.clear }

  describe 'create facebook page' do
    context 'when the object exists' do
      let(:pageid) { described_class.db.create_fb_page('mytwail')[:id] }

      before { pageid } # force creation of the facebook page

      it 'fetches a facebook page using its id' do
        get "/v2.10/#{pageid}"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(pageid)
      end

      it 'fetches a facebook page using its alias' do
        get "/v2.10/mytwail"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(pageid)
      end
    end

    context 'when the object does not exist' do
      it 'returns an error when accessing the object via id' do
        get "/v2.10/1234"
        expect(json_body).to eq(
          "error" => {
            "message" => "Unsupported get request. Object with ID '1234' does not exist, cannot be loaded due to " \
              "missing permissions, or does not support this operation. Please read the Graph API documentation at " \
              "https://developers.facebook.com/docs/graph-api",
            "type" => "GraphMethodException",
            "code" => 100,
            "error_subcode" => 33,
          }
        )
      end

      it 'returns an error when accessing the object via alias' do
        get "/v2.10/sometwail"
        expect(json_body).to eq(
          "error" => {
            "message" => "(#803) Some of the aliases you requested do not exist: sometwail",
            "type" => "OAuthException",
            "code" => 803,
          }
        )
      end
    end
  end

  describe 'create new business account' do
    context 'when the object exists' do
      let(:id) { described_class.db.create_business_acc[:id] }

      before { id } # force creation of the business account

      it 'fetches a business account using its id' do
        get "/v2.10/#{id}"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
      end
    end

    context 'when the object does not exist' do
      it 'returns an error when accessing the object via id' do
        get "/v2.10/1234"
        expect(json_body).to eq(
          "error" => {
            "message" => "Unsupported get request. Object with ID '1234' does not exist, cannot be loaded due to " \
              "missing permissions, or does not support this operation. Please read the Graph API documentation at " \
              "https://developers.facebook.com/docs/graph-api",
            "type" => "GraphMethodException",
            "code" => 100,
            "error_subcode" => 33,
          }
        )
      end
    end
  end

  describe 'create new ad account' do
    context 'when the object exists' do
      let(:id) { described_class.db.create_ad_acc[:id] }

      before { id } # force creation of the ad account

      it 'fetches an ad account using its id' do
        get "/v2.10/#{id}"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
      end
    end

    context 'when the object does not exist' do
      it 'returns an error when accessing the object via id' do
        get "/v2.10/1234"
        expect(json_body).to eq(
          "error" => {
            "message" => "Unsupported get request. Object with ID '1234' does not exist, cannot be loaded due to " \
              "missing permissions, or does not support this operation. Please read the Graph API documentation at " \
              "https://developers.facebook.com/docs/graph-api",
            "type" => "GraphMethodException",
            "code" => 100,
            "error_subcode" => 33,
          }
        )
      end
    end
  end

  describe 'create new ad' do
    context 'when the object exists' do
      let(:id) { described_class.db.create_ad[:id] }

      before { id } # force creation of the ad

      it 'fetches an ad using its id' do
        get "/v2.10/#{id}"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
      end
    end

    context 'when the object does not exist' do
      it 'returns an error when accessing the object via id' do
        get "/v2.10/1234"
        expect(json_body).to eq(
          "error" => {
            "message" => "Unsupported get request. Object with ID '1234' does not exist, cannot be loaded due to " \
              "missing permissions, or does not support this operation. Please read the Graph API documentation at " \
              "https://developers.facebook.com/docs/graph-api",
            "type" => "GraphMethodException",
            "code" => 100,
            "error_subcode" => 33,
          }
        )
      end
    end
  end

  describe 'create new ad set' do
    context 'when the object exists' do
      let(:id) { described_class.db.create_ad_set[:id] }

      before { id } # force creation of the ad set

      it 'fetches an ad set using its id' do
        get "/v2.10/#{id}"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
      end
    end

    context 'when the object does not exist' do
      it 'returns an error when accessing the object via id' do
        get "/v2.10/1234"
        expect(json_body).to eq(
          "error" => {
            "message" => "Unsupported get request. Object with ID '1234' does not exist, cannot be loaded due to " \
              "missing permissions, or does not support this operation. Please read the Graph API documentation at " \
              "https://developers.facebook.com/docs/graph-api",
            "type" => "GraphMethodException",
            "code" => 100,
            "error_subcode" => 33,
          }
        )
      end
    end
  end

  describe 'create new ad creative' do
    context 'when the object exists' do
      let(:id) { described_class.db.create_ad_creative[:id] }

      before { id } # force creation of the ad creative

      it 'fetches an ad creative using its id' do
        get "/v2.10/#{id}"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
      end
    end

    context 'when the object does not exist' do
      it 'returns an error when accessing the object via id' do
        get "/v2.10/1234"
        expect(json_body).to eq(
          "error" => {
            "message" => "Unsupported get request. Object with ID '1234' does not exist, cannot be loaded due to " \
              "missing permissions, or does not support this operation. Please read the Graph API documentation at " \
              "https://developers.facebook.com/docs/graph-api",
            "type" => "GraphMethodException",
            "code" => 100,
            "error_subcode" => 33,
          }
        )
      end
    end
  end

  describe 'create new campaign' do
    context 'when the object exists' do
      let(:id) { described_class.db.create_campaign[:id] }

      before { id } # force creation of the campaign

      it 'fetches a campaign using its id' do
        get "/v2.10/#{id}"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
      end
    end

    context 'when the object does not exist' do
      it 'returns an error when accessing the object via id' do
        get "/v2.10/1234"
        expect(json_body).to eq(
          "error" => {
            "message" => "Unsupported get request. Object with ID '1234' does not exist, cannot be loaded due to " \
              "missing permissions, or does not support this operation. Please read the Graph API documentation at " \
              "https://developers.facebook.com/docs/graph-api",
            "type" => "GraphMethodException",
            "code" => 100,
            "error_subcode" => 33,
          }
        )
      end
    end
  end

  describe 'writing and reading insights' do
    context 'with an ad account' do
      let(:id) { described_class.db.create_ad_acc[:id] }

      before do
        id # force creation of the ad account
        described_class.db.set_insights(id, '12345', reach: 698_967, impressions: 4_853_894, clicks: 567)
      end

      it 'fetches the insights' do
        get "/v2.10/#{id}/insights?ids=[12345]"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
        expect(json_body['insights']).to eq([{ "reach" => 698_967, "impressions" => 4_853_894, "clicks" => 567 }])
      end
    end

    context 'with a campaign' do
      let(:id) { described_class.db.create_campaign[:id] }

      before { id } # force creation of the campaign

      it 'is not possible to set the insights' do
        expect { described_class.db.set_insights(id, '12345', reach: 698_967, impressions: 4_853_894, clicks: 567) }
          .to raise_error(FacebookMock::ApiError)
      end

      it 'is not possible to read the insights' do
        get "/v2.10/#{id}/insights?ids=[12345]"
        expect(json_body).to eq(
          "error" => {
            "message" => "(#803) The edge insights, you requested does not exist for this node.",
            "type" => "OAuthException",
            "code" => 803,
          }
        )
      end
    end
  end

  describe 'writing and reading assigned_users' do
    context 'with a fb_page' do
      let(:id) { described_class.db.create_fb_page("mytwail")[:id] }

      before { id } # force creation of the fb page

      before do
        described_class.db.set_assigned_users(
          id,
          [{ id: 258_924_589, permitted_roles: %w[INSIGHTS_ANALYST ADVERTISER], access_status: "CONFIRMED" },
           { id: 485_695_791, permitted_roles: %w[ADVERTISER], access_status: "PENDING" }]
        )
      end

      it 'fetches the assigned users' do
        get "/v2.10/#{id}/assigned_users"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
        expect(json_body['data']).to eq(
          [{ "id" => 258_924_589, "permitted_roles" => %w[INSIGHTS_ANALYST ADVERTISER], "access_status" => "CONFIRMED" },
           { "id" => 485_695_791, "permitted_roles" => %w[ADVERTISER], "access_status" => "PENDING" }]
        )
      end
    end

    context 'with a campaign' do
      let(:id) { described_class.db.create_campaign[:id] }

      before { id } # force creation of the campaign

      it 'is not possible to set the assigned_users' do
        expect do
          described_class.db.set_assigned_users(
            id,
            [{ id: 258_924_589, permitted_roles: %w[INSIGHTS_ANALYST ADVERTISER], access_status: "CONFIRMED" },
             { id: 485_695_791, permitted_roles: %w[ADVERTISER], access_status: "PENDING" }]
          )
        end.to raise_error(FacebookMock::ApiError)
      end

      it 'is not possible to read the assigned_users' do
        get "/v2.10/#{id}/assigned_users"
        expect(json_body).to eq(
          "error" => {
            "message" => "(#803) The edge assigned_users, you requested does not exist for this node.",
            "type" => "OAuthException",
            "code" => 803,
          }
        )
      end
    end
  end

  describe 'writing and reading ads' do
    context 'with a ad_set' do
      let(:id) { described_class.db.create_ad_set[:id] }

      before { id } # force creation of the ad_set

      before do
        described_class.db.set_ads(id, %w[45248 84358 546995])
      end

      it 'fetches the ads using its id' do
        get "/v2.10/#{id}/ads"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
        expect(json_body['data']).to eq(%w[45248 84358 546995])
      end
    end

    context 'with a campaign' do
      let(:id) { described_class.db.create_campaign[:id] }

      before { id } # force creation of the campaign

      it 'is not possible to set the ads' do
        expect { described_class.db.set_ads(id, %w[45248 84358 546995]) }.to raise_error(FacebookMock::ApiError)
      end

      it 'is not possible to read the ads' do
        get "/v2.10/#{id}/ads"
        expect(json_body).to eq(
          "error" => {
            "message" => "(#803) The edge ads, you requested does not exist for this node.",
            "type" => "OAuthException",
            "code" => 803,
          }
        )
      end
    end
  end

  describe 'writing and reading pages' do
    context 'with a business_account' do
      let(:id) { described_class.db.create_business_acc[:id] }

      before { id } # force creation of the business_acc

      before do
        described_class.db.set_pages(id, %w[45248 84358 546995])
      end

      it 'fetches the pages' do
        get "/v2.10/#{id}/pages"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
        expect(json_body['data']).to eq(%w[45248 84358 546995])
      end
    end

    context 'with a campaign' do
      let(:id) { described_class.db.create_campaign[:id] }

      before { id } # force creation of the campaign

      it 'is not possible to set the pages' do
        expect { described_class.db.set_pages(id, %w[45248 84358 546995]) }.to raise_error(FacebookMock::ApiError)
      end

      it 'is not possible to read the pages' do
        get "/v2.10/#{id}/pages"
        expect(json_body).to eq(
          "error" => {
            "message" => "(#803) The edge pages, you requested does not exist for this node.",
            "type" => "OAuthException",
            "code" => 803,
          }
        )
      end
    end
  end

  describe 'writing and reading adcreatives' do
    context 'with an ad without fields' do
      let(:id) { described_class.db.create_ad[:id] }

      before do
        id # force creation of the ad
        described_class.db.set_adcreatives(
          id,
          [{ id: '32164173',
             object_story_spec: { page_id: '1342355463',
                                  link_data: { link: "https:example.com/test1", message: 'sample message 1' } } },
           { id: '32164173',
             object_story_spec: { page_id: '1342309463',
                                  link_data: { link: "https:example.com/test2", message: 'sample message 2' } } }]
        )
      end

      it 'fetches the adcreatives' do
        get "/v2.10/#{id}/adcreatives"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
        expect(json_body['data']).to eq([{ "id" => '32164173'}, { "id" => '32164173' }])
      end

      it 'fetches the adcreatives fields' do
        get "/v2.10/#{id}/adcreatives?fields=['object_story_spec']"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
        expect(json_body['data']).to eq(
          [{ "id" => '32164173',
             "object_story_spec" => { "page_id" => '1342355463',
                                      "link_data" => { "link" => "https:example.com/test1",
                                                       "message" => 'sample message 1' } } },
           { "id" => '32164173',
             "object_story_spec" => { "page_id" => '1342309463',
                                      "link_data" => { "link" => "https:example.com/test2",
                                                       "message" => 'sample message 2' } } }]
        )
      end
    end

    context 'with a campaign' do
      let(:id) { described_class.db.create_campaign[:id] }

      before { id } # force creation of the campaign

      it 'is not possible to set the adcreatives' do
        expect { described_class.db.set_adcreatives(id, %w[45248 84358 546995]) }.to raise_error(FacebookMock::ApiError)
      end

      it 'is not possible to read the adcreatives' do
        get "/v2.10/#{id}/adcreatives"
        expect(json_body).to eq(
          "error" => {
            "message" => "(#803) The edge adcreatives, you requested does not exist for this node.",
            "type" => "OAuthException",
            "code" => 803,
          }
        )
      end
    end
  end
end
