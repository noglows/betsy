class OrderItemsController < ApplicationController

  def create
    my_order
    @order.save
    cookies[:order] = @order.id

    item = @order.order_items.where(product_id: params[:product_id])

    unless item.empty?
      item.first.increment!(:quantity, by = order_item_params[:quantity].to_i)
    else
      @order.order_items << OrderItem.create(order_item_params)
    end

    redirect_to cart_path
  end

  def cart
    @order_items = my_order.order_items
  end

  def update
  end

  def destroy
  end

  def order_item_params
    params.require(:order_item).permit(:quantity).merge(product_id: params[:product_id])
  end
end
