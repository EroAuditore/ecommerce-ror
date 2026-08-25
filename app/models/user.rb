class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable

  has_many :carts, dependent: :nullify
  has_many :orders, dependent: :restrict_with_error
  has_many :addresses, dependent: :destroy
end
