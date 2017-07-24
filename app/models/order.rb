class Order < ApplicationRecord
  belongs_to :user, foreign_key: :merchant_id
  has_one :assigned
  has_one :pickup, through: :assigned
  has_one :delivered, through: :assigned

  validates :merchant_id, :cust_name, :cust_street_ad, :cust_city_town, :cust_state, :cust_zipcode, :cust_country, :cust_phone_number, presence: true
end
