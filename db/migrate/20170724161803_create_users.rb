class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :phone_number, null: false
      t.string :user_type, null: false
      t.string :street_address
      t.string :city_town
      t.string :state
      t.string :zipcode
      t.string :country

      t.timestamps
    end
  end
end
