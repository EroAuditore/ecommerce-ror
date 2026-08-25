class Orders::CreateService
  def initialize(user:, cart:, shipping_address:)
    @user = user
    @cart = cart
    @shipping_address = shipping_address
  end

  def call
    return ServiceResult.failure("El carrito está vacío") if @cart.cart_items.empty?

    out_of_stock = @cart.cart_items.select { |item| item.quantity > item.product.stock }
    if out_of_stock.any?
      names = out_of_stock.map { |item| item.product.name }.join(", ")
      return ServiceResult.failure("Sin stock suficiente para: #{names}")
    end

    order = nil

    ActiveRecord::Base.transaction do
      order = Order.create!(
        user: @user,
        shipping_address: @shipping_address,
        total_amount: @cart.cart_items.sum { |item| item.unit_price * item.quantity },
        placed_at: Time.current
      )

      @cart.cart_items.each do |item|
        order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          unit_price: item.unit_price
        )
        item.product.decrement!(:stock, item.quantity)
      end

      @cart.cart_items.destroy_all
    end

    ServiceResult.success(order)
  rescue ActiveRecord::RecordInvalid => e
    ServiceResult.failure(e.record.errors.full_messages)
  end
end
