class User < ApplicationRecord
  has_secure_password
  has_many :carts
  has_many :orders
  validates :username, presence: true, length: {maximum: 15}
  validates :password, presence:true, length: {minimum: 6}
end