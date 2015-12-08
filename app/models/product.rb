class Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_items
  has_and_belongs_to_many :categories

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :user_id, presence: true
end
