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
    #binding.pry
    revenue = 0
    products.each do |product|
      product.order_items.each do |oi|
        if oi.order.status != "cancelled"
          revenue += (product.price * oi.quantity)
        end
      end
    end
    return revenue
  end

  def revenue_by_status(status)
    revenue = 0
    products.each do |product|
      product.order_items.each do |oi|
        if oi.order.status == status
            revenue += (product.price * oi.quantity)
        end
      end
    end
    return revenue
  end

  def num_orders
    orders = []
    products.each do |product|
      product.order_items.each do |oi|
        if orders.include? oi.order.id
          next
        else
          orders.push(oi.order.id)
        end
      end
    end
    return orders.length
  end

  def num_orders_by_status(status)
    orders = []
    products.each do |product|
      product.order_items.each do |oi|
        if oi.order.status == status
          if orders.include? oi.order
            next
          else
            orders.push(oi.order)
          end
        end
      end
    end
    return orders.length
  end


end
