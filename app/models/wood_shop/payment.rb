module WoodShop
  class Payment < ApplicationRecord
    has_many :delivery_payments
    has_many :deliveries, through: :delivery_payments
  end
end
