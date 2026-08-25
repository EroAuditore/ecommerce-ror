class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :stock, null: false, default: 0
      t.string :slug, null: false
      t.datetime :published_at
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.uuid :created_by_id
      t.uuid :updated_by_id

      t.timestamps
    end

    add_index :products, :slug, unique: true
    add_foreign_key :products, :users, column: :created_by_id
    add_foreign_key :products, :users, column: :updated_by_id
  end
end
