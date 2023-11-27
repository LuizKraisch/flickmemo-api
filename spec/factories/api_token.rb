# frozen_string_literal: true

FactoryBot.define do
  factory :api_token do
    active { true }
    token { 'aNiCeToKen' }
    user_id
  end
end
