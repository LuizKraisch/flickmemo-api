# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    title { 'Watched' }
    list_type { 'watched' }
    user_id
  end
end
