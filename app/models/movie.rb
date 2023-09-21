# frozen_string_literal: true

class Movie < ApplicationRecord
  has_and_belongs_to_many :lists
  has_many :reviews

  validates :external_id, presence: true
end
