# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    external_id { '123456' }
    title { 'A nice movie' }
    poster_path { 'https://path-to-a-nice-poster.com' }
  end
end
