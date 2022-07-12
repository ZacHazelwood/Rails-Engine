FactoryBot.define do
  factory :item do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    unit_price { Faker::Commerce.price }
    association :merchant
  end
end
