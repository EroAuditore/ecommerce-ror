class Cart::AddItemService
  def initialize(cart:, product:, quantity:)
    @cart = cart
    @product = product
    @quantity = quantity
  end

  def call
    return ServiceResult.failure("La cantidad debe ser mayor a cero") if @quantity <= 0

    item = @cart.cart_items.find_or_initialize_by(product: @product)
    requested_total = item.new_record? ? @quantity : item.quantity + @quantity

    if requested_total > @product.stock
      return ServiceResult.failure("Stock insuficiente para #{@product.name}")
    end

    item.quantity = requested_total
    item.unit_price = @product.price

    if item.save
      ServiceResult.success(item)
    else
      ServiceResult.failure(item.errors.full_messages)
    end
  end
end
