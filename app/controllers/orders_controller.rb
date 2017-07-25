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

  def create
    @order = Order.new(order_params)
    if @order.save
      status 200
    else
      status 400
    end
  end

  def update
    
  end

  private

  def order_params
    params.require(:merchant_id, :items, :total, :cust_name, :cust_street_address,
    :cust_city_town, :cust_state, :cust_zipcode, :cust_country, :cust_phone).permit(merchant_id, :items, :total, :cust_name, :cust_street_address,
    :cust_city_town, :cust_state, :cust_zipcode, :cust_country, :cust_phone)
  end
end
