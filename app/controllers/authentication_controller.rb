class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def login
    @user = User.find_by_email(params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      token = encode_token(user_id: @user.id)
      render json: {token: token, massage: 'Login succesfully'}, status: :ok
    else
      render json: {error: 'unauthorized'}, status: :unauthorized
    end
  end
end
