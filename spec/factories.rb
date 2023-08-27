FactoryBot.define do
  factory(:list) do
    name { Faker::Name.initials }
  end
end
