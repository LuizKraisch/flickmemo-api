# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:reviews) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_presence_of(:title) }
  end
end
