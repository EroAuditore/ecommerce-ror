module Types
  class OrderItemType < Types::BaseObject
    field :id, ID, null: false
    field :product, Types::ProductType, null: false
    field :quantity, Integer, null: false
    field :unit_price, Float, null: false
  end
end
