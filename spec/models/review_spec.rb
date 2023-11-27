# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:user) }
  end

  describe '#to_hash' do
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }
    let(:review) { create(:review, user:, movie:) }
    let(:expected_hash) do
      {
        uuid: review.uuid,
        score: review.score,
        note: review.note,
        note_has_spoilers: review.note_has_spoilers,
        favorite: review.favorite,
        created_at: review.created_at
      }
    end

    it 'return the review as a hash' do
      expect(review.to_hash).to eq(:expected_hash)
    end
  end
end
