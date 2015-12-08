class ProductsController < ApplicationController

  def index
    @products = Product.all
    user_id = session[:user_id]
      if user_id.nil?
        @user_name = "Guest"
      else
        @user_name = User.find(user_id).first_name
      end
  end

end
