class Cart::MergeService
  def initialize(guest_cart:, user_cart:)
    @guest_cart = guest_cart
    @user_cart = user_cart
  end

  def call
    ActiveRecord::Base.transaction do
      @guest_cart.cart_items.each do |guest_item|
        existing_item = @user_cart.cart_items.find_by(product_id: guest_item.product_id)

        if existing_item
          merged_quantity = [ existing_item.quantity + guest_item.quantity, guest_item.product.stock ].min
          existing_item.update!(quantity: merged_quantity)
        else
          guest_item.update!(cart_id: @user_cart.id)
        end
      end

      @guest_cart.destroy
    end

    ServiceResult.success(@user_cart.reload)
  rescue ActiveRecord::RecordInvalid => e
    ServiceResult.failure(e.record.errors.full_messages)
  end
end
