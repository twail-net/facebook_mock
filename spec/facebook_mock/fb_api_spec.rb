# frozen_string_literal: true

RSpec.describe FacebookMock::FbApi do
  def app
    FacebookMock::FbApi # this defines the active application for this test
  end

  def json_body
    JSON.parse(last_response.body)
  end

  after { described_class.db.clear }

  describe 'get object id' do
    context 'when the object exists' do
      let(:pageid) { described_class.db.create_fb_page('mytwail')[:id] }

      before { pageid } # force creation of the facebook page

      it 'fetches a facebook page using its id' do
        get "/v2.10/#{pageid}"
        expect(json_body['id']).to eq(pageid)
      end

      it 'fetches a facebook page using its alias' do
        get "/v2.10/mytwail"
        expect(last_response).to be_ok
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
end
