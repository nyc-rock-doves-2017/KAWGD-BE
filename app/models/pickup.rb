class Pickup < ApplicationRecord
  belongs_to :assigned

  validates :assigned_id, :pickup_time, presence: true
end
