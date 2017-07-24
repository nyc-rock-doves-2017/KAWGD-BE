class OrderDelivered < ApplicationRecord
  belongs_to :order

  validates :order_id, :delivered_time, presence: true
end
