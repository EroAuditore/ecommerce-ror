class Mutations::AddToCart < Mutations::BaseMutation
  include Mutations::ResolvesCart

  argument :product_id, ID, required: true
  argument :quantity, Integer, required: true
  argument :session_token, String, required: false

  field :cart, Types::CartType, null: true
  field :errors, [ String ], null: false

  def resolve(product_id:, quantity:, session_token: nil)
    product = Product.find_by(id: product_id)
    return { cart: nil, errors: [ "Producto no encontrado" ] } unless product

    cart = find_or_create_cart(session_token)
    result = Cart::AddItemService.new(cart: cart, product: product, quantity: quantity).call

    if result.success?
      { cart: cart.reload, errors: [] }
    else
      { cart: cart, errors: result.errors }
    end
  end
end
