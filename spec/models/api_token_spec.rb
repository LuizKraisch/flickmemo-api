# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiToken, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:active) }
    it { is_expected.to validate_uniqueness_of(:token) }
  end

  describe 'callbacks' do
    describe 'before_create' do
      it 'generates a token and sets active to true' do
        api_token = build(:api_token)
        api_token.save
        expect(api_token.token).to be_present
        expect(api_token.active).to eq(true)
      end
    end
  end
end
