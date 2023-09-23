# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_and_belong_to_many(:lists) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:external_id) }
  end
end
