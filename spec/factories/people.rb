FactoryBot.define do
  factory :person do
    first_name { Faker::Name.first_name }
    email { Faker::Internet.email }
  end
end
