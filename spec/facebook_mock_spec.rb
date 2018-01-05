# frozen_string_literal: true

RSpec.describe FacebookMock do
  it "has a version number" do
    expect(FacebookMock::VERSION).not_to be nil
  end

  # insights
  context "create insights" do
    subject { described_class }

    before do
      id = FacebookMock::FbApi.db.create_ad_acc
      subject.set_insights(id, '123456789', reach: 698_967, impressions: 4_853_894, clicks: 567)
    end

    it 'returns the stored insights' do
      expect(subject.get_insights(id, '123456789')).to_eq(reach: 698_967, impressions: 4_853_894, clicks: 567)
    end
  end
end
