FactoryBot.define do
  factory :api_token do
    user { nil }
    active { false }
    token { "MyText" }
  end

  factory :user do
    
  end

  factory(:list) do
    name { Faker::Name.initials }
  end
end
