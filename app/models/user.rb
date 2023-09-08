# frozen_string_literal: true

class User < ApplicationRecord
  has_one :api_token
  has_many :list

  validates :google_user_uid, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  encrypts :google_user_uid, deterministic: true
end
