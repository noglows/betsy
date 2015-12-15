class OrdersController < ApplicationController
  before_action :current_user

  before_action :check_user_id, only: [:index, :show, :ship]

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
    @instock = @order.instock
    @total = @order.cart_total

    redirect_to root_path if @order.new_record? || @instock.empty?
  end

  def update
    my_order

    @order.attributes = order_params

    if @order.save
      @order.update(status: "paid")
      redirect_to cart_path
    else
      @instock = @order.instock
      render :checkout
    end
  end

  # N
  def ship
    user_id = params[:user_id]
    order_id = params[:order_id]
    order = Order.find(order_id)
    is_complete = true

    order.order_items.each do |oi|
      if oi.product.user.id == user_id.to_i
        oi.shipped = true
        oi.save
      end
    end
    order.order_items.each do |oi|
      if oi.shipped == false
        is_complete = false
      end
    end
    if is_complete == true
      order.status = "complete"
      order.save
    end
    redirect_to user_orders_path(user_id)
  end

  private

  def order_params
    last_four = params[:order][:last_four][-4..-1]
    params.require(:order).permit(:email, :mailing_address, :zip, :name_on_card, :card_exp).merge(last_four: last_four)
  end
end
