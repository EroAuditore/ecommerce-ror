FactoryBot.define do
  factory :order do
    association :user
    status { "pending" }
    payment_status { "unpaid" }
    total_amount { 199.99 }
    shipping_address { { street: "Reforma 123", city: "CDMX", zip: "06600", country: "MX" } }
    placed_at { Time.current }

    trait :cancelled do
      status { "cancelled" }
    end

    trait :paid do
      payment_status { "paid" }
    end
  end
end
