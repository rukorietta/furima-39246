class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.references :order, null: false, foreign_key: true
      t.string :postal_code
      t.integer :prefecture_id
      t.string :city
      t.string :address
      t.string :building_name
      t.string :phone_number

      t.timestamps
    end
  end
end
