class OrdersController < ApplicationController
  before_action :current_user
  before_action :check_user_id, only: [:index, :show, :ship]
  before_action :my_order, only: [:checkout, :shipping_estimate, :update_billing]

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

    raise


    # API call to our app, which includes
    # needs to include destination address (country, state, city, zip)
    # needs to include info about each package: value (cost)
    # carrier (ex., ups)
    # my_order
    # shipping_params = {"destination" => { :country => "US", :state => params[:state], :city => params[:city], :zip => params[:zip]}, "value" => my_order.cart_total, "carrier" => params[:carrier]}
    # query = shipping_params.to_query
    # response = HTTParty.get("http://localhost:3000/?#{query}", format: :json).parsed_response

    # somehow store in instance variables the @cost and @date, so we can then use them in the view
    # to display the cost and delivery date to the user on the checkout page.
    # value = my_order.cart_total
    # @service_type = response[:service_name]
    # @cost = response[:total_price]
    # @delivery_est = response[:delivery_date]
    # @total_cost = @cost + value
    render :shipping
  end

  def update_billing
    @order.attributes = address_params
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

      render :checkout
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
    params.require(:order).permit(:email, :mailing_address, :zip)
  end

  def billing_params
    last_four = params[:order][:last_four][-4..-1]
    params.require(:order).permit(:name_on_card, :card_exp).merge(last_four: last_four)
  end

end
