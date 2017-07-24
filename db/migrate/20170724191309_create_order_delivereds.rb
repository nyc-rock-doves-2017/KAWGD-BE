class CreateOrderDelivereds < ActiveRecord::Migration[5.1]
  def change
    create_table :order_delivereds do |t|
      t.integer :order_id, null: false
      t.datetime :delivered_time, null: false

      t.timestamps
    end
  end
end
