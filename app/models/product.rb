class Product < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :reviews
  has_and_belongs_to_many :categories

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :user_id, presence: true
  validates :inventory_total, presence: true
  validates :inventory_total, numericality: { greater_than_or_equal_to: 0}

  def average_rating
    sum = self.reviews.average(:rating).to_f
  end
end
