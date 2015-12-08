class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  validates :status, presence: true
  validates :user_id, presence: true
end
