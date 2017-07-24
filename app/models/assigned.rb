class Assigned < ApplicationRecord
  belongs_to :order, foreign_key: :order_id
  has_one :pickup
  has_one :delivered

  validates :order_id, :assignment_time, :deliverer_id, presence: true
end
