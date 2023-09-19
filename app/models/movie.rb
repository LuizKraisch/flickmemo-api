# frozen_string_literal: true

class Movie < ApplicationRecord
  has_and_belongs_to_many :list
  has_one :user

  validates :movie_external_id, presence: true
end
