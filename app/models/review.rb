# frozen_string_literal: true

class Review < ApplicationRecord
  has_one :movie
  belongs_to :user

  validates :note_has_spoilers, presence: true
  validates :favorite, presence: true
end
