class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  validates :status, presence: true
  validates :user_id, presence: true

  def total
    revenue = 0
    order_items.each do |oi|
      revenue += (oi.product.price * oi.quantity)
    end
    return revenue
  end
  
end
