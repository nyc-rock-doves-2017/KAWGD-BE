# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170724191309) do

  create_table "assigneds", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "deliverer_id", null: false
    t.datetime "assignment_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delivereds", force: :cascade do |t|
    t.integer "assigned_id", null: false
    t.datetime "delivered_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "merchant_id", null: false
    t.integer "deliverer_id"
    t.string "items", null: false
    t.float "total_price", null: false
    t.string "cust_name", null: false
    t.string "cust_street_ad", null: false
    t.string "cust_city_town", null: false
    t.string "cust_state", null: false
    t.string "cust_zipcode", null: false
    t.string "cust_country", null: false
    t.string "cust_phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pickups", force: :cascade do |t|
    t.integer "assigned_id", null: false
    t.datetime "pickup_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password", null: false
    t.string "phone_number", null: false
    t.string "user_type", null: false
    t.string "street_address"
    t.string "city_town"
    t.string "state"
    t.string "zipcode"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
