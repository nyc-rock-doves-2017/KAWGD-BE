class SessionsController < ApplicationController
  def index
    @user = User.all
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      render json: {id: @user.id, name: @user.name}
    else
      status 400
    end
  end

end
