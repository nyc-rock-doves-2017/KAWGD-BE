class OrdersController < ApplicationController
  def index
    @orders = Order.all
    @unassigned_orders = []
    @assigned = Assigned.all
    @assigned_orders = []
    @assigned.each do |assigned|
      @assigned_orders << assigned.order_id
    end
    @orders.each do |order|
      if @assigned_orders.exclude?(order.id)
        @unassigned_orders << order
      end
    end
    render json: @unassigned_orders
  end
end
