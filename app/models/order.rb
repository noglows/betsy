class Order < ActiveRecord::Base
  has_many :order_items

  validates :status, presence: true

  def total(user_id)
    revenue = 0
    order_items.each do |oi|
      if oi.product.user.id == user_id
        revenue += (oi.product.price * oi.quantity)
      end
    end
    return revenue
  end

  def instock
    self.order_items.enough_inventory?
  end

  def outofstock
    self.order_items.not_enough_inventory?
  end
end
