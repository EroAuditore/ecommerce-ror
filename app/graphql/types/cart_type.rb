module Types
  class CartType < Types::BaseObject
    field :id, ID, null: false
    field :session_token, String, null: false
    field :cart_items, [ Types::CartItemType ], null: false
    field :total_items, Integer, null: false
    field :subtotal, Float, null: false

    def total_items
      object.cart_items.sum(:quantity)
    end

    def subtotal
      object.cart_items.sum { |item| item.unit_price * item.quantity }
    end
  end
end
