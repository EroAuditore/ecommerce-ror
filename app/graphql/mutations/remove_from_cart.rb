class Mutations::RemoveFromCart < Mutations::BaseMutation
  include Mutations::ResolvesCart

  argument :product_id, ID, required: true
  argument :session_token, String, required: false

  field :cart, Types::CartType, null: true
  field :errors, [ String ], null: false

  def resolve(product_id:, session_token: nil)
    product = Product.find_by(id: product_id)
    return { cart: nil, errors: [ "Producto no encontrado" ] } unless product

    cart = find_cart(session_token)
    return { cart: nil, errors: [ "No se encontró un carrito" ] } unless cart

    result = Cart::RemoveItemService.new(cart: cart, product: product).call

    if result.success?
      { cart: cart.reload, errors: [] }
    else
      { cart: cart, errors: result.errors }
    end
  end
end
