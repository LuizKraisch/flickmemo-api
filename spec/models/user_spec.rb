# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:api_token) }
    it { is_expected.to have_many(:lists) }
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_many(:movies).through(:reviews) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:google_user_uid) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:preferred_language) }
  end
end
