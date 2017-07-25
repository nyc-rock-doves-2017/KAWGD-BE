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
        if order.assigned != nil
          @data << custom_order_json(order)
          # Wan needs order_id and delivered_time
        else
          @data << order
        end
      end
      render json: @data
    else
      assigned = Assigned.where(deliverer_id: @user.id)
      @orders = []
      assigned.each do |assigned_object|
        @orders << Order.find_by(id: assigned_object.order_id)
      end
      render json: @orders
    end
  end

  private

  def user_params
    params.require(:email, :password, :phone_number, :user_type).permit(:email, :password, :phone_number, :user_type)
  end

  def custom_order_json(order_object)
    {
      order_id: order_object.id,
      delivery_time: total_delivery_time(order_object),
      city: order_object.cust_city_town,
      country: order_object.cust_country,
      name: order_object.cust_name,
      phone: order_object.cust_phone_number,
      state: order_object.cust_state,
      street: order_object.cust_street_ad,
      zipcode: order_object.cust_zipcode,
      items: order_object.items,
      total_price: order_object.total_price
    }
  end

  def total_delivery_time(order_object)
    time = order_object.delivered.delivered_time - order_object.created_at
  end

end
