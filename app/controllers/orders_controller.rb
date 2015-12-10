class OrdersController < ApplicationController
  before_action :current_user

  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
    @orders = []
    @user.products.each do |product|
      product.order_items.each do |oi|
        if @orders.include? oi.order
          next
        else
          @orders.push(oi.order)
        end
      end
    end
    @orders.sort_by! { |obj| obj.updated_at }
    return @orders

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
    @user = User.find(user_id)
  end
end
