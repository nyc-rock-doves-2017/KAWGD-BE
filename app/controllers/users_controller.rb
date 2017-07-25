class UsersController < ActionController::API

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user.id
      status 200
    else
      status 400
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.user_type == "merchant"
      orders = Order.where(merchant_id: @user.id)
      @data = []
      orders.each do |order|
        @data << merchant_order_json(order)
      end
      render json: @data
    else
      assigned = Assigned.where(deliverer_id: @user.id)
      @data = []
      assigned.each do |assigned_object|
        @data << bikeboy_orders_json(Order.find_by(id: assigned_object.order_id))
      end
      render json: @data
    end
  end

  private

  def user_params
    params.require(:email, :name, :password, :phone_number, :user_type).permit(:email, :name, :password, :phone_number, :user_type)
  end

  def merchant_order_json(order_object)
    if order_object.assigned != nil
      return { orderId: order_object.id,
              totalDeliveryTime: total_delivery_time(order_object),
              assignedTime: order_object.assigned.assignment_time,
              pickupTime: order_object.pickup.pickup_time,
              deliveredTime: order_object.delivered.delivered_time,
              orderTime: order_object.created_at,
              city: order_object.cust_city_town,
              country: order_object.cust_country,
              customerName: order_object.cust_name,
              phone: order_object.cust_phone_number,
              state: order_object.cust_state,
              street: order_object.cust_street_ad,
              zipcode: order_object.cust_zipcode,
              items: order_object.items,
              totalPrice: order_object.total_price
            }
    else
      return { orderId: order_object.id,
              totalDeliveryTime: nil,
              totalDeliveryTime: nil,
              assignedTime: nil,
              pickupTime: nil,
              deliveredTime: nil,
              orderTime: order_object.created_at,
              city: order_object.cust_city_town,
              country: order_object.cust_country,
              customerName: order_object.cust_name,
              phone: order_object.cust_phone_number,
              state: order_object.cust_state,
              street: order_object.cust_street_ad,
              zipcode: order_object.cust_zipcode,
              items: order_object.items,
              totalPrice: order_object.total_price
            }
    end
  end

  def total_delivery_time(order_object)
    time = order_object.delivered.delivered_time - order_object.created_at
  end

  def bikeboy_orders_json(order_object)
    return { orderId: order_object.id,
            totalDeliveryTime: total_delivery_time(order_object),
            assignedTime: order_object.assigned.assignment_time,
            pickupTime: order_object.pickup.pickup_time,
            deliveredTime: order_object.delivered.delivered_time,
            orderTime: order_object.created_at,
            city: order_object.cust_city_town,
            country: order_object.cust_country,
            customerName: order_object.cust_name,
            phone: order_object.cust_phone_number,
            state: order_object.cust_state,
            street: order_object.cust_street_ad,
            zipcode: order_object.cust_zipcode,
            items: order_object.items,
            totalPrice: order_object.total_price
          }
  end

end
