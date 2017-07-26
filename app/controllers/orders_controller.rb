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
    # @assigned = @order.assigned
    # @pickup = @order.pickup
    # @delivered = @order.delivered
    @deliverer = User.find_by(id: params[:deliverer_id])
    @case = params[:status]
    if @case == "assignment"
      Assigned.create(order_id: @order.id, deliverer_id: @deliverer.id, assignment_time: DateTime.now)
    elsif @case == "pickup"
      Pickup.create(assigned_id: @order.assigned.id, pickup_time: DateTime.now)
    elsif @case == "delivered"
      Delivered.create(assigned_id: @order.assigned.id, delivered_time: DateTime.now)
    else
      render json: { error: 400 }
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
    if @pickup = Pickup.find_by(assigned_id: @assigned.id)
      @pickup = @pickup.pickup_time
    else
      @pickup = nil
    end

    if @delivered = Delivered.find_by(assigned_id: @assigned.id)
      @delivered = @delivered.delivered_time
    else
      @delivered = nil
    end
    @bikeboy = User.find_by(id: @assigned.deliverer_id)
    @merchant = User.find_by(id: @order.merchant_id)

    @details = [ {
      orderId: @order.id,
      bikeboyId: @bikeboy.id,
      bikeboyName: @bikeboy.name,
      assigned: @assigned.assignment_time,
      pickup: @pickup,
      droppedOff: @delivered,
      merchantName: @merchant.name,
      merchantId: @merchant.id
      } ]
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
