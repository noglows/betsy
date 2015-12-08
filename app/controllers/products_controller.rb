class ProductsController < ApplicationController

  def index
    @products = Product.all
    @user_id = session[:user_id]
      if @user_id.nil?
        @user_name = "Guest"
      else
        @user_name = User.find(@user_id).first_name
      end

    @categories = Category.all
    @markets = User.all
    case params[:order]
    when "prod"
      @order = "prod"
      @products = Product.order(:name)
    when "mart"
      @order = "mart"
      @products = Product.order(name)
    when "cat"
      @order = "cat"
      @products = Product.order(:name)
    end
  end

end
