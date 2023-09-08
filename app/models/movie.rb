# frozen_string_literal: true

class Movie < ApplicationRecord
  belongs_to :list

  validate :movie_external_id, presence: true
  validate :note_has_spoilers, presence: true
  validate :favorite, presence: true
end
