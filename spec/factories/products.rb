FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Producto #{n}" }
    description { "Descripción de prueba" }
    price { 199.99 }
    stock { 10 }
    published_at { 1.day.ago }
    association :category

    trait :out_of_stock do
      stock { 0 }
    end

    trait :unpublished do
      published_at { nil }
    end
  end
end
