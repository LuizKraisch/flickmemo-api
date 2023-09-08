# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    movie_external_id { 'MyString' }
    score { 1 }
    note { 'MyText' }
    note_has_spoilers { false }
    favorite { false }
  end

  factory :list do
    user_id { nil }
    type { '' }
  end

  factory :api_token do
    user { nil }
    active { false }
    token { 'MyText' }
  end

  factory :user do
    first_name { 'MyText' }
    last_name { 'MyText' }
    email { 'MyText' }
    bio { 'MyText' }
    google_id_token { 'MyText' }
  end
end
