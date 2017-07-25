class SessionsController < ApplicationController
  def index
    @user = User.all
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      render json: {id: @user.id, name: @user.name}
    else
      render json: {
        error: "No such user; check the submitted email address",
        status: 400
      }, status: 400
    end
  end

end
