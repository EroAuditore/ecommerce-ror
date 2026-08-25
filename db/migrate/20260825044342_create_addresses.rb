class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :street, null: false
      t.string :city, null: false
      t.string :zip, null: false
      t.string :country, null: false, default: "MX"
      t.boolean :default, null: false, default: false

      t.timestamps
    end
  end
end
