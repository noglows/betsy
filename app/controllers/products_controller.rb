class ProductsController < ApplicationController

  def index
    @products = Product.all
    @user_id = session[:user_id]
      if @user_id.nil?
        @user_name = "Guest"
      else
        @user_name = User.find(@user_id).first_name
      end
    @categoies = Category.all
    @merchants = User.all
    case params[:order]
    when "prod"
      @order = "prod"
      @sort_by = nil
      @products = Product.order(:name)
    when "mart"
      @order = "mart"
      @sort_by = User.all
      @products = Product.order(name)
    when "cat"
      @order = "cat"
      @sort_by = Category.all
      @products = Product.order(:name)
    end
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = Review.all.reverse
  end

  def review
    Review.create(review_params)

    redirect_to product_path(params[:product_id])
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

  # def destroy
  #   product_id = params[:id]
  #   Product.destroy(product_id)
  #   redirect_to user_path(params[:user_id])
  # end

  def retire
    product_id = params[:product_id]
    user_id = params[:user_id]
    product = Product.find(product_id)
    product.retired = true
    product.save
    redirect_to user_path(user_id)
  end

  private

  def review_params
    params.require(:review).permit(:review_text, :rating).merge(product_id: params[:product_id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :inventory_total, :retired, :image_url, :user_id)
  end

end
