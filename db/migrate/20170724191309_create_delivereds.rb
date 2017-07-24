class CreateDelivereds < ActiveRecord::Migration[5.1]
  def change
    create_table :delivereds do |t|
      t.integer :assigned_id, null: false
      t.datetime :delivered_time, null: false

      t.timestamps
    end
  end
end
