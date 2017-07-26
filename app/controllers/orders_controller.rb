class OrdersController < ApplicationController
  def index
    @orders = Order.all
    @unassigned_orders = []
    @unassigned_orders_camelized = []
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

    @unassigned_orders.each do |order|
      @unassigned_orders_camelized << camel_order(order)
    end

    render json: @unassigned_orders_camelized
  end

  def show
    @order = Order.find_by(id: params[:id])
    render json: @order
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order
    else
      render json: {
        error: "Invalid User. Please check your input and try again.",
        status: 400
      }, status: 400
    end
  end

  def update
    @order = Order.find_by(id: params[:id])
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
    render json: order_details(@order)

  end

  private

  def order_params
    params.require(:order).permit(:merchant_id, :items, :total_price, :cust_name, :cust_street_ad,
    :cust_city_town, :cust_state, :cust_zipcode, :cust_country, :cust_phone_number)
  end

  def order_details(order_object)
    @order = Order.find_by(id: order_object.id)
    @assigned = Assigned.find_by(order_id: @order.id)
    @pickup = Pickup.find_by(assigned_id: @assigned.id)
    @delivered = Delivered.find_by(assigned_id: @assigned.id)
    @bikeboy = User.find_by(id: @assigned.deliverer_id)
    @merchant = User.find_by(id: @order.merchant_id)
    @details = [{orderId: @order.id, bikeboyId: @bikeboy.id, bikeboyName: @bikeboy.name, assigned: @assigned.assignment_time, pickup: @pickup.pickup_time, droppedOff: @delivered.delivered_time, merchantName: @merchant.name, merchantId: @merchant.id}]
    return @details
  end

  def camel_order(order_object)
    return {id: order_object.id,
            merchantId: order_object.merchant_id,
            item: order_object.items,
            total: order_object.total_price,
            custName: order_object.cust_name,
            custStreetAddress: order_object.cust_street_ad,
            custCityTown: order_object.cust_city_town,
            custState: order_object.cust_state,
            custZipcode: order_object.cust_zipcode,
            custCountry: order_object.cust_country,
            custPhone: order_object.cust_phone_number}
  end

end
