class OrderAssigned < ApplicationRecord
  belongs_to :order

  validates :order_id, :assignment_time, presence: true
end
