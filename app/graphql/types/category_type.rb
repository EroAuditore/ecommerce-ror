module Types
  class CategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :slug, String, null: false
    field :parent, Types::CategoryType, null: true
    field :children, [ Types::CategoryType ], null: false
    field :products, [ Types::ProductType ], null: false
  end
end
