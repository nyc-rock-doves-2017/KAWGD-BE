class CreateOrderPickups < ActiveRecord::Migration[5.1]
  def change
    create_table :order_pickups do |t|
      t.integer :order_id, null: false
      t.datetime :pickup_time, null: false

      t.timestamps
    end
  end
end
