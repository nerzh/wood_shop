module WoodShop
  class Delivery < ApplicationRecord
    has_many :delivery_payments
    has_many :payments, through: :delivery_payments
  end
end
