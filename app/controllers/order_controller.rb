class OrderController < ApplicationController
  def index
    @orders = Order.where(assigned: )
  end
end
