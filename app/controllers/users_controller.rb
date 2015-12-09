class UsersController < ApplicationController
  before_action :current_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:error] = "Passwords don't match"
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
