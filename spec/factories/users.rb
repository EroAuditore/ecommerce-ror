FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    confirmed_at { Time.current }
    role { "customer" }

    trait :admin do
      role { "admin" }
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end
  end
end
