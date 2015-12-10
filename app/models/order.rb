class Order < ActiveRecord::Base
  has_many :order_items
  #belongs_to :user

  validates :status, presence: true
  #validates :user_id, presence: true

  def total(user_id)
    revenue = 0
    order_items.each do |oi|
      if oi.product.user.id == user_id
        #binding.pry
        revenue += (oi.product.price * oi.quantity)
      end
    end
    return revenue
  end

end
