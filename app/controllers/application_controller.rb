class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    logged_in_user || guest_user
  end

  def my_order
    unless cookies[:order].nil?
      @order ||= Order.find(cookies[:order])
    else
      @order = Order.new(status: "pending")
    end
  end

  def logged_in_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def guest_user
    @guest ||= Guest.new(nil)
  end
end
