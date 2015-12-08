class ProductsController < ApplicationController

  def index
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
