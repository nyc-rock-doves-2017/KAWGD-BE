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

  def show
    @order = Order.find_by(id: params[:id])
    render json: @order
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
    @order = Order.find_by(id: params[:order_id])
    @assigned = Assigned.find_by(order_id: @order.id)
    @pickup = Pickup.find_by(assigned_id: @assigned.id)
    @delivered = Delivered.find_by(assigned_id: @assigned.id)
    @deliverer = User.find_by(id: params[:deliverer_id])
    @case = params[:case]
    if @case == "assignment"
      @assigned.assignment_time = Time.now
    elsif @case == "pickup"
      @pickup.pickup_time = Time.now
    else
      @delivered.delivered_time = Time.now
    end
    render json: @order.order_details

  end

  private

  def order_params
    params.require(:merchant_id, :items, :total, :cust_name, :cust_street_address,
    :cust_city_town, :cust_state, :cust_zipcode, :cust_country, :cust_phone).permit(merchant_id, :items, :total, :cust_name, :cust_street_address,
    :cust_city_town, :cust_state, :cust_zipcode, :cust_country, :cust_phone)
  end

  def order_details
    @order = Order.find_by(id: params[:id])
    @assigned = Assigned.find_by(order_id: @order.id)
    @pickup = Pickup.find_by(assigned_id: @assigned.id)
    @delivered = Delivered.find_by(assigned_id: @assigned.id)
    @bikeboy = User.find_by(id: @assigned.deliverer_id)
    @merchant = User.find_by(id: @order.merchant_id)
    @details = [{orderId: @order.id, bikeboyId: @bikeboy.id, bikeboyName: @bikeboy.name, assigned: @assigned.assignment_time, pickup: @pickup.pickup_time, droppedOff: @delivered.delivered_time, merchantName: @merchant.name, merchantId: @merchant.id}]
    return @details
  end
end
