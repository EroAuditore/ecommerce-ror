class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts, id: :uuid do |t|
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.string :session_token, null: false
      t.datetime :expires_at

      t.timestamps
    end

    add_index :carts, :session_token, unique: true
  end
end
