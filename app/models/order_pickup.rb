class OrderPickup < ApplicationRecord
  belongs_to :order

  validates :order_id, :pickup_time, presence: true
end
