# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie
  has_one :user

  validates :note_has_spoilers, presence: true
  validates :favorite, presence: true
end
