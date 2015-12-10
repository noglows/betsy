class OrdersController < ApplicationController
  before_action :current_user

  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
  end

  def show
    user_id = params[:user_id]
    order_id = params[:id]
    @order = Order.find(order_id)

    @cookie = true unless cookies[:order].nil?
  end

  def cart
    @order_items = my_order.order_items
  end

  def update

  end
end
