# frozen_string_literal: true

class Review < ApplicationRecord
  has_one :movie
  belongs_to :user

  validates :note_has_spoilers, presence: true
  validates :favorite, presence: true

  def to_hash
    {
      uuid:,
      score:,
      note:,
      note_has_spoilers:,
      favorite:,
      created_at:
    }
  end
end
