class Order < ApplicationRecord
  include Auditable

  belongs_to :user
  has_many :order_items, dependent: :restrict_with_error
  has_many :products, through: :order_items

  enum :status, {
    pending: "pending",
    confirmed: "confirmed",
    shipped: "shipped",
    delivered: "delivered",
    cancelled: "cancelled"
  }

  enum :payment_status, {
    unpaid: "unpaid",
    paid: "paid",
    refunded: "refunded"
  }
end
