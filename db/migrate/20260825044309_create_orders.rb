class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :status, null: false, default: "pending"
      t.string :payment_status, null: false, default: "unpaid"
      t.decimal :total_amount, precision: 10, scale: 2, null: false
      t.jsonb :shipping_address, null: false, default: {}
      t.datetime :placed_at
      t.uuid :created_by_id
      t.uuid :updated_by_id

      t.timestamps
    end

    add_foreign_key :orders, :users, column: :created_by_id
    add_foreign_key :orders, :users, column: :updated_by_id
  end
end
