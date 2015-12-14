class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def my_order
    unless cookies[:order].nil?
      @order ||= Order.find(cookies.signed[:order])
    else
      @order = Order.new(status: "pending")
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def instock
    my_order.order_items.find_all { |item| item.enough_inventory? }
  end

  def outofstock
    my_order.order_items.find_all { |item| !item.enough_inventory? }
  end
end
