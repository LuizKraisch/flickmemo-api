# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

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
