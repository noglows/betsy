class UsersController < ApplicationController
  before_action :current_user

  before_action :require_login, only: [:show, :new_category]
  before_action :check_user_id, only: [:show]

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
    @category = Category.new
  end

  def new_category
    user_id = params[:user_id]
    @category = Category.new(category_params)
    if @category.save
      session[:message] = "You have created a new category: #{@category.name}"
      redirect_to user_path(user_id)
    else
      flash[:error] = "Sorry, you didn't successfully create a new category"
      redirect_to user_path(user.id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
