FactoryBot.define do
  factory :address do
    association :user
    street { "Av. Reforma 123" }
    city { "Ciudad de México" }
    zip { "06600" }
    country { "MX" }
    default { false }

    trait :default do
      default { true }
    end
  end
end
