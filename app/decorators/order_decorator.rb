class OrderDecorator < Draper::Decorator
  delegate_all

  STATUS_LABELS = {
    "pending" => "Pendiente",
    "confirmed" => "Confirmada",
    "shipped" => "Enviada",
    "delivered" => "Entregada",
    "cancelled" => "Cancelada"
  }.freeze

  STATUS_CSS_CLASSES = {
    "pending" => "bg-yellow-100 text-yellow-800",
    "confirmed" => "bg-blue-100 text-blue-800",
    "shipped" => "bg-indigo-100 text-indigo-800",
    "delivered" => "bg-green-100 text-green-800",
    "cancelled" => "bg-red-100 text-red-800"
  }.freeze

  def formatted_total
    helpers.number_to_currency(total_amount)
  end

  def status_label
    STATUS_LABELS.fetch(status, status.to_s.capitalize)
  end

  def status_css_class
    STATUS_CSS_CLASSES.fetch(status, "bg-gray-100 text-gray-800")
  end

  def placed_at_formatted
    return "Sin confirmar" if placed_at.blank?

    placed_at.strftime("%d/%m/%Y %H:%M")
  end
end
