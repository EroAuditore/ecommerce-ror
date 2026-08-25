class Cart::RemoveItemService
  def initialize(cart:, product:)
    @cart = cart
    @product = product
  end

  def call
    item = @cart.cart_items.find_by(product: @product)
    return ServiceResult.failure("El producto no está en el carrito") unless item

    item.destroy
    ServiceResult.success(@cart)
  end
end
