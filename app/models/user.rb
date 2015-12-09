class User < ActiveRecord::Base
  has_many :products
  has_many :orders

  has_secure_password

  validates :email, presence: true
  validates_uniqueness_of :email
  validates :email, email_format: { message: "doesn't look like an email address" }

  def revenue
    revenue = 0
    orders.each do |order|
      if order.status != "cancelled"
        order_items = order.order_items
        order_items.each do |order_item|
          product = order_item.product
          revenue += (product.price * order_item.quantity)
          end
      end
    end
    return revenue
  end

  def revenue_by_status(status)
    revenue = 0
    status_orders = orders.where(status: status)
    status_orders.each do |order|
      order_items = order.order_items
      order_items.each do |order_item|
        product = order_item.product
        revenue += (product.price * order_item.quantity)
        end
      end
    return revenue
  end

end
