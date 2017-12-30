# frozen_string_literal: true

RSpec.describe FacebookMock::Database do
  subject { described_class.new }

  describe 'create_fb_page' do
    before { subject.create_fb_page('someid') }

    it 'stores a new facebook page in the database' do
      expect(subject.find('someid')[:id]).not_to be_nil
    end

    it 'does not allow to create duplicates' do
      expect { subject.create_fb_page('someid') }.to raise_error('Alias already exists')
    end
  end
end
