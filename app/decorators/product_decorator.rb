class ProductDecorator < Draper::Decorator
  delegate_all

  LOW_STOCK_THRESHOLD = 5

  def formatted_price
    helpers.number_to_currency(price)
  end

  def stock_status
    if stock <= 0
      "Agotado"
    elsif stock <= LOW_STOCK_THRESHOLD
      "Últimas unidades"
    else
      "Disponible"
    end
  end

  def stock_badge_class
    if stock <= 0
      "bg-red-100 text-red-800"
    elsif stock <= LOW_STOCK_THRESHOLD
      "bg-yellow-100 text-yellow-800"
    else
      "bg-green-100 text-green-800"
    end
  end
end
