class OrdersController < ApplicationController
  before_action :current_user

  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
    @orders = []
    @user.products.each do |product|
      product.order_items.each do |oi|
        if params[:sort] != 'all'
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

  def update
    @user = User.find(user_id)
  end
end
