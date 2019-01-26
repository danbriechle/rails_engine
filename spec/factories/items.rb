FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Item Name #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:unit_price) { |n| ("#{n}".to_i+1)*2 }

    association :merchant, factory: :merchant
  end
end
