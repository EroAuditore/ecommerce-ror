FactoryBot.define do
  factory :cart do
    sequence(:session_token) { |n| "session-token-#{n}" }
    expires_at { 7.days.from_now }
    user { nil }

    trait :for_user do
      association :user
    end
  end
end
