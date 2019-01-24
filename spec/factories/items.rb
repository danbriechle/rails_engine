FactoryBot.define do
  factory :item do
    name { "ItemName" }
    description {"Description"}
    unit_price { 1 }
    association :merchant, factory: :merchant, name: "merchnt_name"
  end
end
