module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :status, String, null: false
    field :payment_status, String, null: false
    field :total_amount, Float, null: false
    field :shipping_address, GraphQL::Types::JSON, null: false
    field :placed_at, GraphQL::Types::ISO8601DateTime, null: true
    field :order_items, [ Types::OrderItemType ], null: false

    # Reusan el OrderDecorator de la Fase 4, mismo motivo que en ProductType.
    field :formatted_total, String, null: false
    field :status_label, String, null: false
    field :status_css_class, String, null: false
    field :placed_at_formatted, String, null: false

    def formatted_total
      object.decorate.formatted_total
    end

    def status_label
      object.decorate.status_label
    end

    def status_css_class
      object.decorate.status_css_class
    end

    def placed_at_formatted
      object.decorate.placed_at_formatted
    end
  end
end
