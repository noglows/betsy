module OrderItemsHelper

  def print_cart_total
    if @instock.length == 1
      return "You have #{@instock.length} item in your cart!"
    else
      return "You have #{@instock.length} items in your cart!"
    end
  end

end
