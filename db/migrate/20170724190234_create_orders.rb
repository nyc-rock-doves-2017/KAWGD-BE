class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :merchant_id, null: false
      t.integer :deliverer_id
      t.string :items, null: false
      t.float :total_price, null: false
      t.string :cust_name, null: false
      t.string :cust_street_ad, null: false
      t.string :cust_city_town, null: false
      t.string :cust_state, null: false
      t.string :cust_zipcode, null: false
      t.string :cust_country, null: false
      t.string :cust_phone_number, null: false

      t.timestamps
    end
  end
end
