module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :price, Float, null: false
    field :stock, Integer, null: false
    field :slug, String, null: false
    field :published_at, GraphQL::Types::ISO8601DateTime, null: true
    field :category, Types::CategoryType, null: false

    # Reusan el ProductDecorator de la Fase 4 en vez de duplicar el
    # formateo acá: un solo lugar decide cómo se ve el precio/stock.
    field :formatted_price, String, null: false
    field :stock_status, String, null: false
    field :stock_badge_class, String, null: false

    def formatted_price
      object.decorate.formatted_price
    end

    def stock_status
      object.decorate.stock_status
    end

    def stock_badge_class
      object.decorate.stock_badge_class
    end
  end
end
