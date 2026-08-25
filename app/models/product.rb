class Product < ApplicationRecord
  include Sluggable
  include Publishable
  include Auditable

  belongs_to :category
  has_many :cart_items, dependent: :restrict_with_error
  has_many :order_items, dependent: :restrict_with_error

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
end
