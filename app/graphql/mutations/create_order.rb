class Mutations::CreateOrder < Mutations::BaseMutation
  argument :shipping_address, GraphQL::Types::JSON, required: true

  field :order, Types::OrderType, null: true
  field :errors, [ String ], null: false

  def resolve(shipping_address:)
    user = context[:current_user]
    return { order: nil, errors: [ "Debes iniciar sesión para completar la compra" ] } unless user

    cart = user.carts.order(created_at: :desc).first
    return { order: nil, errors: [ "No tienes un carrito activo" ] } unless cart

    result = Orders::CreateService.new(user: user, cart: cart, shipping_address: shipping_address).call

    if result.success?
      { order: result.value, errors: [] }
    else
      { order: nil, errors: result.errors }
    end
  end
end
