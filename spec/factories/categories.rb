FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Categoría #{n}" }

    trait :child do
      association :parent, factory: :category
    end
  end
end
