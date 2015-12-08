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

  def new
    @product = Product.new
    @action = "create"
  end

  def create
    @user_id = session[:user_id]
    @product = Product.new(product_params)
    if @product.save
      redirect_to user_path(@user_id)
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @action = "update"
  end

  def update
    user_id = session[:user_id]
    @product = Product.update(params[:id], product_params)
    if @product.save
      redirect_to user_path(user_id)
    else
      render "new"
    end
  end

  def destroy
    product_id = params[:id]
    Product.destroy(product_id)
    redirect_to user_path(params[:user_id])
  end

  private

  def product_params
        params.require(:product).permit(:name, :description, :price, :inventory_total, :retired, :image_url, :user_id)
  end

end
