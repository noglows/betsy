require './lib/services/service_estimate'

class OrdersController < ApplicationController
  before_action :current_user
  before_action :check_user_id, only: [:index, :show, :ship]
  before_action :my_order, only: [:checkout, :shipping_estimate, :update_billing, :confirmation]

  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
    @orders = []
    @user.products.each do |product|
      product.order_items.each do |oi|
        if ['pending','paid','cancelled','complete'].include? params[:sort]
          if oi.order.status == params[:sort] && (@orders.include? oi.order)
            next
          else
            @orders.push(oi.order)
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
    session[:order] = nil
    session[:total] = nil
    @instock = @order.instock
    @total = @order.cart_total
    @errors = @order.errors.messages
    cookies.signed[:stocked] = @order.instock.length

    redirect_to root_path if @order.new_record? || @instock.empty?
  end

  def shipping_estimate
    @order.attributes = address_params
    @test = [my_order.mailing_address, my_order.zip, my_order.email]
    @instock = @order.instock
    @total = @order.cart_total
    @errors = @order.errors.messages

    query = {"destination" => { :state => @order.state, :city => @order.city, :zip => @order.zip}, "value" => @order.cart_total}.to_query

    parsed_response = (HTTParty.get("http://localhost:3000/?#{query}", format: :json)).parsed_response

    # this is an array of estimate objects, each has a service code, date, and cost:
    @ups_estimates = ServiceEstimates.get_service_estimates(parsed_response["UPS Service Options"])

    @usps_estimates = ServiceEstimates.get_service_estimates(parsed_response["USPS Service Options"])

    render :shipping
  end

  def update_billing
    @order.attributes = billing_params
    @instock = @order.instock

    if @order.save && cookies.signed[:stocked] == @instock.length
      @order.update(status: "paid")
      @order.outofstock.destroy_all

      redirect_to confirmation_path
    elsif cookies.signed[:stocked] != @instock.length
      cookies.delete :stocked
      redirect_to cart_path, alert: "Your cart has changed."
    else
      @order.last_four = nil
      @total = @order.cart_total
      @errors = @order.errors.messages

      redirect_to confirmation_path
    end
  end

  def confirmation
    if session[:order].nil?
      my_order
      session[:order] = @order.id
      session[:total] = @order.cart_total
      @order.adjust_stock
      cookies.delete :order
    else
      @order = Order.find(session[:order].to_i)
    end
    @order_items = @order.order_items
  end

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

  def address_params
    params.require(:order).permit(:email, :mailing_address, :city, :state, :zip)
  end

  def billing_params
    last_four = params[:patch][:last_four][-4..-1]
    params.require(:patch).permit(:name_on_card, :card_exp).merge(last_four: last_four)
  end

end
