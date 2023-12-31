# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    score { 10.0 }
    note { 'A nice review' }
    note_has_spoilers { false }
    favorite { false }
  end
end
