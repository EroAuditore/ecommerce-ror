class Orders::CancelService
  CANCELLABLE_STATUSES = %w[pending confirmed].freeze

  def initialize(order:)
    @order = order
  end

  def call
    unless CANCELLABLE_STATUSES.include?(@order.status)
      return ServiceResult.failure("No se puede cancelar una orden en estado '#{@order.status}'")
    end

    ActiveRecord::Base.transaction do
      @order.order_items.each do |item|
        item.product.increment!(:stock, item.quantity)
      end
      @order.update!(status: :cancelled)
    end

    ServiceResult.success(@order)
  rescue ActiveRecord::RecordInvalid => e
    ServiceResult.failure(e.record.errors.full_messages)
  end
end
