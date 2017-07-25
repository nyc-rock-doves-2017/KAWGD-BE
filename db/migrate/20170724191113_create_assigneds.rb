class CreateAssigneds < ActiveRecord::Migration[5.1]
  def change
    create_table :assigneds do |t|
      t.integer :order_id, null: false
      t.integer :deliverer_id
      t.datetime :assignment_time

      t.timestamps
    end
  end
end
