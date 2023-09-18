# frozen_string_literal: true

class User < ApplicationRecord
  has_one :api_token
  has_many :lists
  has_many :movies, through: :lists

  after_create :create_token

  validates :google_user_uid, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :preferred_language, presence: true

  private

  def create_token
    self.api_token = ApiToken.create(user_id: id, active: true)
    save
  end
end
