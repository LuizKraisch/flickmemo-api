# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    google_user_uid { '123456789' }
    first_name { 'Test' }
    last_name { 'User' }
    email { 'me@email.com' }
    preferred_language { 'pt-BR' }
    photo_url { 'https://path-to-a-nice-photo.com' }
    api_token { create(:api_token) }
  end
end
