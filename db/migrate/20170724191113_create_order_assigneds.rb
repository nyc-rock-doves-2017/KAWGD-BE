class CreateOrderAssigneds < ActiveRecord::Migration[5.1]
  def change
    create_table :order_assigneds do |t|
      t.integer :order_id, null: false
      t.datetime :assignment_time, null: false

      t.timestamps
    end
  end
end
