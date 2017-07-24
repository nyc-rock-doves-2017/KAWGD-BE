class CreateOrderPlaceds < ActiveRecord::Migration[5.1]
  def change
    create_table :order_placeds do |t|
      t.integer :order_id, null: false
      t.datetime :order_time, null: false

      t.timestamps
    end
  end
end
