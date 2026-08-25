# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :add_to_cart, mutation: Mutations::AddToCart
    field :remove_from_cart, mutation: Mutations::RemoveFromCart
    field :create_order, mutation: Mutations::CreateOrder
  end
end
