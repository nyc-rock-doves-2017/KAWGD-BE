class Delivered < ApplicationRecord
  belongs_to :assigned

  validates :assigned_id, :delivered_time, presence: true
end
