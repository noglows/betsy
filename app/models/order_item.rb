class OrderItem < ActiveRecord::Base
  belongs_to :order

  belongs_to :product

  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true }
  validates :product_id, presence: true
  validates :order_id, presence: true

end
