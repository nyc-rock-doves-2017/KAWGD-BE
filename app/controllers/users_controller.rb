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
          @data << order
          @data << order.assigned.delivered
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

end
