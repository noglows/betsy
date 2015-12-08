class User < ActiveRecord::Base
  has_many :products
  has_many :orders

  has_secure_password

  validates :email, presence: true
  validates_uniqueness_of :email
  validates :email, email_format: { message: "doesn't look like an email address" }

end
