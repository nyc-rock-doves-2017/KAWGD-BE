class User < ApplicationRecord
  has_many :orders

  validates :email, :password, :phone_number, :user_type, :name, presence: true
end
