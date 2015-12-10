class OrdersController < ApplicationController
  before_action :current_user

  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
    @orders = []
    @user.products.each do |product|
      product.order_items.each do |oi|
        @orders.push(oi.order)
      end
    end
    @orders.sort_by! { |obj| obj.updated_at }
    return @orders
  end

  def show
    user_id = params[:user_id]
    order_id = params[:id]
    @order = Order.find(order_id)


  end
end
