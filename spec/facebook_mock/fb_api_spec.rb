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
    let(:id) { described_class.db.create_ad_acc[:id] }

    before { id } # force creation of the ad account

    context 'when the object exists' do
      before { described_class.db.set_insights(id, '12345', reach: 698_967, impressions: 4_853_894, clicks: 567) }

      it 'fetches a facebook page using its id' do
        get "/v2.10/#{id}/insights?ids=[12345]"
        expect(last_response).to be_ok
        expect(json_body['id']).to eq(id)
        expect(json_body['insights']).to eq([{ "reach" => 698_967, "impressions" => 4_853_894, "clicks" => 567 }])
      end
    end
  end
end
