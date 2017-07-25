class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email], password: params[:password])
    if user
      render json: "OK"
    else
      render json: {status: 400}
    end
  end
end
