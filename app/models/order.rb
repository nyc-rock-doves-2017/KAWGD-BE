class Order < ApplicationRecord
  belongs_to :user
  has_one :order_placed, :order_assigned, :order_pickup, :order_delivered

  validates :merchant_id, :cust_name, :cust_street_ad, :cust_city_town, :cust_state, :cust_zipcode, :cust_country, :cust_phone_number, presence: true
end
