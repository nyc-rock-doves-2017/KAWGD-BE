class CreatePickups < ActiveRecord::Migration[5.1]
  def change
    create_table :pickups do |t|
      t.integer :assigned_id, null: false
      t.datetime :pickup_time, null: false

      t.timestamps
    end
  end
end
