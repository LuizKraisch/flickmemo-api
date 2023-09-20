# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :movies

  enum list_type: {
    watched: 'watched',
    want_to_watch: 'want_to_watch'
  }

  validates :list_type, presence: true
end
