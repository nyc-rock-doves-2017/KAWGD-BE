class UserController < ActionController::API

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.id.as_json
      status 200
    else
      status 400
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @orders = Order.where(merchant_id: @user.id)
  end

  private

  def user_params
    params.require(:email, :password, :phone_number, :user_type).permit(:email, :password, :phone_number, :user_type)
  end

end
