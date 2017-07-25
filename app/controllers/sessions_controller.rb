class SessionsController < ApplicationController
  def login
    # getting email and password
    @user = User.find_by(email: params[:email])
    if @user
      status 200
      render json: {id: @user.id, name: @user.name}
    else
      status 400
    end
  end
end
