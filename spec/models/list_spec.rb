# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:movies).through(:list_movies) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:list_type) }

    context 'list type enum' do
      it 'defines the list_type enum with the expected values' do
        expect(List.list_types).to eq({ 'watched' => 'watched', 'watchlist' => 'watchlist' })
      end
    end
  end
end
