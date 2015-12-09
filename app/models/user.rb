class User < ActiveRecord::Base
  has_many :products
  #has_many :orders
  has_many :order_items

  has_secure_password

  validates :email, presence: true
  validates_uniqueness_of :email
  validates :email, email_format: { message: "doesn't look like an email address" }

  # switch orders
  def revenue
    revenue = 0
    order_items.each do |oi|
      if oi.order.status != "cancelled"
        product = order_item.product
        revenue += (product.price * order_item.quantity)
      end
    end
    return revenue
  end

  def revenue_by_status(status)
    revenue = 0
    order_items.each do |oi|
      status_orders = oi.orders.where(status: status)
      status_orders.each do |order|
        order_items = order.order_items
        order_items.each do |order_item|
          product = order_item.product
          revenue += (product.price * order_item.quantity)
        end
      end
    end
    return revenue
  end

  def num_orders
    orders = []
    order_items.each do |oi|
      if orders.includes? oi.order
        next
      else
        orders.push(oi.order)
      end
    end
    return orders.length
  end

  def num_orders_by_status(status)
    orders = []
    order_items.each do |oi|
      if oi.order.status == status
        if orders.includes? oi.order
          next
        else
          orders.push(oi.order)
        end
      end
    end
    return orders.length
  end

end
