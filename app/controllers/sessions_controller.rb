class SessionsController < ApplicationController
  def index
    @user = User.all
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      status 200
      render json: {id: @user.id, name: @user.name}
    else
      status 400
    end
  end

end
