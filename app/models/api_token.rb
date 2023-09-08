# frozen_string_literal: true

class ApiToken < ApplicationRecord
  before_create :generate_token

  validates :active, presence: true
  validates :token, presence: true, uniqueness: true

  has_one :user

  encrypts :token, deterministic: true

  private

  def generate_token
    self.token = Digest::MD5.hexdigest(SecureRandom.hex)
    self.active = true
  end
end
