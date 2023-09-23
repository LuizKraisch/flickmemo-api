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
end
