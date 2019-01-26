FactoryBot.define do
  factory :transaction do
    association :invoice, factory: :invoice
    sequence(:credit_card_number) { |n| ("#{n}".to_i+1)*2 }
    sequence(:credit_card_expiration_date) { |n| "12/2/#{(("#{n}".to_i+1)*2)}" }
    result { "Success" }
  end
end
