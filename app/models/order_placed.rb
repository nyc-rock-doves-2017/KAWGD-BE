class OrderPlaced < ApplicationRecord
  belongs_to :order

  validates :order_id, :order_time, presence: true
end
