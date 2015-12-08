class ProductsController < ApplicationController

  def index
    @products = Product.all
    @user_id = session[:user_id]
      if @user_id.nil?
        @user_name = "Guest"
      else
        @user_name = User.find(@user_id).first_name
      end

    @products = Product.order(:name)
    @categories = Category.all
    @markets = User.all
    case params[:order]
    when "prod"
      @order = "prod"
    when "mart"
      @order = "mart"
    when "cat"
      @order = "cat"
    end
  end

end
