class ProductsController < ApplicationController

  def index
    @products = Product.all
    @categories = Category.all
    @markets = User.all
  end

end
