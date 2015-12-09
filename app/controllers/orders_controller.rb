class OrdersController < ApplicationController
  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
  end

  def show
    user_id = params[:user_id]
    order_id = params[:id]
    @order = Order.find(order_id)
  end
end
