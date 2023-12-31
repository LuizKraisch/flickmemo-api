# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :user
  has_many :list_movies
  has_many :movies, through: :list_movies

  enum list_type: {
    watched: 'watched',
    watchlist: 'watchlist'
  }

  validates :title, presence: true
  validates :list_type, presence: true
end
