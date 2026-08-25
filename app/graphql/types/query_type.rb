# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :products, [ Types::ProductType ], null: false do
      argument :category_slug, String, required: false
      argument :min_price, Float, required: false
      argument :max_price, Float, required: false
      argument :in_stock_only, Boolean, required: false
      argument :sort, String, required: false
    end

    def products(**filters)
      Products::FilterQuery.new(filters: filters).call
    end

    field :product, Types::ProductType, null: true do
      argument :slug, String, required: true
    end

    def product(slug:)
      Product.published.find_by(slug: slug)
    end

    field :current_cart, Types::CartType, null: true do
      argument :session_token, String, required: false
    end

    def current_cart(session_token: nil)
      if context[:current_user]
        context[:current_user].carts.order(created_at: :desc).first
      elsif session_token.present?
        Cart.find_by(session_token: session_token)
      end
    end
  end
end
