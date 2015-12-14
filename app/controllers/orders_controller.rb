class OrdersController < ApplicationController
  before_action :current_user

  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
    @orders = []
    @user.products.each do |product|
      product.order_items.each do |oi|
        if ['pending','paid','cancelled','complete'].include? params[:sort]
          if oi.order.status == params[:sort]
            if @orders.include? oi.order
              next
            else
              @orders.push(oi.order)
            end
          end
        else
          if @orders.include? oi.order
            next
          else
            @orders.push(oi.order)
          end
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
    @user = User.find(user_id)

    @cookie = true unless cookies[:order].nil?
  end

  def checkout
    my_order
    redirect_to root_path if @order.new_record?
  end

  def ship
    user_id = params[:user_id]
    order_id = params[:order_id]
    order = Order.find(order_id)
    order.status = "complete"
    order.save
    redirect_to user_orders_path(user_id)
  end
end
