class UserRegistrationsController < ApplicationController
  skip_before_action :authenticate_request, only: :create
  before_action :set_user, only: :show
  

  def index
    @users = User.all
    render json: {
      status: {code: 200},
      data: UserSerializer.new(@users).serializable_hash[:data][:attributes]
    }
  end

  def show
    render json: {
      status: {code: 200},
      data: UserSerializer.new(@user).serializable_hash[:data][:attributes]
    }
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {
        status: 200,
        message: 'Signed up successfully.',
        user: UserSerializer.new(@user).serializable_hash[:data][:attributes]
      }
    else
      render json: { errors: @user.errors , status: 422 }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :name, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
