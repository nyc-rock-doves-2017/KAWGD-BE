class Assigned < ApplicationRecord
  belongs_to :order

  validates :order_id, :assignment_time, :deliverer_id, presence: true
end
