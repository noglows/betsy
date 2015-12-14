require 'pry'

class ProductsController < ApplicationController
  before_action :current_user
  before_action :require_login, only: [:new, :create, :edit, :update, :retire]
  before_action :check_user_product, only: [:review]
  before_action :check_user_id, only: [:retire, :edit, :update]

  def index
    @products = Product.order(:created_at)
    @categories = Category.all
    @merchants = User.all
    case params[:type]
    when 'merch'
      @products = Product.where("user_id = #{params[:order]}")
    when "cat"
      prod = Product.all
      @products = prod.select {|product|
        rows = product.categories.where("category_id = #{params[:order]}")
        !rows.to_a.empty?
      }
    else
      @order = "prod"
      @products = Product.order(:created_at)
    end
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = Review.where("product_id = #{params[:id]}").reverse
    @order_item = my_order.order_items.new
  end

  def review
    Review.create(review_params)

    redirect_to product_path(params[:product_id])
  end

  def new
    @product = Product.new
    @action = "create"
    @categories = @product.categories
    @all_categories = Category.all
  end

  def create
    @user_id = session[:user_id]
    @product = Product.new(product_params)
    params[:categories].each do |cat|
      @product.categories << Category.where(id:cat.to_i)
    end
    if @product.save
      redirect_to user_path(@user_id)
    else
      render :edit
    end
  end

  def edit
    @product = Product.find(params[:id])
    @action = "update"
    @categories = @product.categories
    @all_categories = Category.all
  end

  def update
    user_id = session[:user_id]
    @product = Product.update(params[:id], product_params)
    @product.categories.clear
    @product.save
    params[:categories].each do |cat|
      @product.categories << Category.where(id:cat.to_i)
    end
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
